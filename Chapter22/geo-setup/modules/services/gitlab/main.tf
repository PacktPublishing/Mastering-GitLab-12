provider "aws" {
  region = "${var.region}"
}

module "keypair" {
   source = "../keypair"
   region = "${var.region}"
}
resource "aws_instance" "gitlab_host" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    subnet_id = "${aws_subnet.subnet_public_frontend.id}"
    key_name = "${module.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.sg_gitlab.id}"]
    instance_type = "${var.instance_type}"
}
resource "aws_instance" "bastion_host" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    subnet_id = "${aws_subnet.subnet_public_frontend.id}"
    key_name = "${module.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.sg_bastionhost.id}"]
    instance_type = "t2.micro"
}

resource "aws_elb" "lb" {
    subnets = ["${aws_subnet.subnet_public_frontend.id}"]
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "TCP:80"
        interval = 30
    }
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
    listener {
        instance_port = 5432
        instance_protocol = "tcp"
        lb_port = 5432
        lb_protocol = "tcp"
    }
     listener {
        instance_port = 22
        instance_protocol = "tcp"
        lb_port = 22
        lb_protocol = "tcp"
    }
    cross_zone_load_balancing = true
    instances = ["${aws_instance.gitlab_host.id}"]
    security_groups = ["${aws_security_group.sg_lb.id}"]
}

resource "aws_internet_gateway" "internet_gateway_main" {
  vpc_id = "${aws_vpc.gitlab_ha.id}"
}

resource "aws_security_group" "sg_gitlab"
{
    vpc_id = "${aws_vpc.gitlab_ha.id}"
    description = "Security group for gitlab host"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.sg_bastionhost.id}"]
        description = "Allow incoming SSH traffic from bastion host"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.sg_bastionhost.id}"]
        description = "Allow incoming SSH traffic from bastion host"
    }
    ingress {
      from_port = -1
      to_port = -1
      protocol = "ICMP"
      security_groups = ["${aws_security_group.sg_bastionhost.id}"]
      description = "Allow incoming ICMP from management IPs"
    }
    ingress {
       from_port = 0
       to_port = 0
       protocol = -1
       self = true
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }
    egress {
        from_port = 3128
        to_port = 3128
        protocol = "TCP"
        security_groups = ["${aws_security_group.sg_bastionhost.id}"]
    }
    egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
    }
}

resource "aws_security_group_rule" "lbhttpaccess" {
    security_group_id = "${aws_security_group.sg_gitlab.id}"
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.sg_lb.id}"
    description = "Allow HTTP access from loadbalancers"
}

resource "aws_security_group_rule" "lbpostgresaccess" {
    security_group_id = "${aws_security_group.sg_gitlab.id}"
    type = "ingress"
    from_port = 5432
    to_port = 5432
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.sg_lb.id}"
    description = "Allow Postgres access from loadbalancers"
}

resource "aws_security_group_rule" "lbgitsshaccess" {
    security_group_id = "${aws_security_group.sg_gitlab.id}"
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.sg_lb.id}"
    description = "Allow git over ssh access from loadbalancers"
}

resource "aws_security_group" "sg_bastionhost" {
  vpc_id = "${aws_vpc.gitlab_ha.id}"
  description = "Security group for bastion host"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["${var.mgmt_ips}"]
      description = "Allow incoming SSH from management IPs"
  }
  ingress {
      from_port = -1
      to_port = -1
      protocol = "ICMP"
      cidr_blocks = ["${var.mgmt_ips}"]
      description = "Allow incoming ICMP from management IPs"
  }
  egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
  }
}
resource "aws_security_group_rule" "webproxyaccess" {
    security_group_id = "${aws_security_group.sg_bastionhost.id}"
    type = "ingress"
    from_port = 3128
    to_port = 3128
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.sg_gitlab.id}"
    description = "Allow Squid proxy access from gitlab server"
}

resource "aws_security_group" "sg_lb"
{
    vpc_id = "${aws_vpc.gitlab_ha.id}"
    description = "Security group for the load-balancer"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming HTTP traffic from anywhere"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming git ssh traffic from anywhere"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming HTTPS traffic from anywhere"
    }
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming Postgres from anywhere"
    }
    egress {
        from_port = 5432
        to_port = 5432
        protocol = "TCP"
        security_groups = ["${aws_security_group.sg_gitlab.id}"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.sg_gitlab.id}"]
    }
     egress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        security_groups = ["${aws_security_group.sg_gitlab.id}"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        security_groups = ["${aws_security_group.sg_gitlab.id}"]
    }
}


resource "aws_subnet" "subnet_public_frontend" {
  availability_zone = "${var.region}a"
  cidr_block = "${var.subnet_frontend_cidr_block}" 
  map_public_ip_on_launch = true 
  vpc_id = "${aws_vpc.gitlab_ha.id}"
}



resource "aws_vpc" "gitlab_ha" {
  cidr_block = "${var.vpc_cidr_block}" 
  enable_dns_hostnames = true  
  enable_dns_support = true  
}

resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.gitlab_ha.id}"

  route {
      cidr_block = "0.0.0.0/0" 
      gateway_id = "${aws_internet_gateway.internet_gateway_main.id}"
  }

  tags {
      Name = "Default route table"
  }
}

resource "aws_route_table_association" "rt_frontend" {
  subnet_id = "${aws_subnet.subnet_public_frontend.id}"
  route_table_id = "${aws_route_table.default.id}"
}



 
 