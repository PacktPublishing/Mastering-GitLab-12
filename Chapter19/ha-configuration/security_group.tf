resource "aws_security_group" "SG-loadbalancer" {
    name = "SG-loadbalancer"
    vpc_id = "${aws_vpc.gitlabha.id}"
    description = "Security group for the load-balancer"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming HTTP traffic from anywhere"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow incoming HTTPS traffic from anywhere"
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-frontendservers.id}"]
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-frontendservers.id}"]
    }

    tags = {
        Name = "SG-loadbalancers"
    }
}
resource "aws_security_group" "SG-frontendservers" {
    name = "SG-frontendservers"
    vpc_id = "${aws_vpc.gitlabha.id}"
    description = "Security group for frontendservers"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
        description = "Allow incoming SSH traffic from bastion hosts"
    }
    ingress {
      from_port = -1
      to_port = -1
      protocol = "ICMP"
      security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
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
        security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
    }
    egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
    }
    tags = {
        Name = "SG-frontendservers"
    }
}

resource "aws_security_group" "SG-bastionhosts" {
  name = "SG-bastionhosts"
  vpc_id = "${aws_vpc.gitlabha.id}"
  description = "Security group for bastion hosts"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = "${var.mgmt_ips}"
      description = "Allow incoming SSH from management IPs"
  }

  ingress {
      from_port = -1
      to_port = -1
      protocol = "ICMP"
      cidr_blocks = "${var.mgmt_ips}"
      description = "Allow incoming ICMP from management IPs"
  }
  egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
  }
  tags = {
      Name = "SG-bastionhosts"
  }
}

resource "aws_security_group_rule" "lbhttpaccess" {
    security_group_id = "${aws_security_group.SG-frontendservers.id}"
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.SG-loadbalancer.id}"
    description = "Allow Squid proxy access from loadbalancers"
}

resource "aws_security_group_rule" "lbhttpsaccess" {
    security_group_id = "${aws_security_group.SG-frontendservers.id}"
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.SG-loadbalancer.id}"
    description = "Allow Squid proxy access from loadbalancers"
}

resource "aws_security_group_rule" "webproxyaccess" {
    security_group_id = "${aws_security_group.SG-bastionhosts.id}"
    type = "ingress"
    from_port = 3128
    to_port = 3128
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.SG-frontendservers.id}"
    description = "Allow Squid proxy access from frontend servers"
}

resource "aws_security_group_rule" "dbproxyaccess" {
    security_group_id = "${aws_security_group.SG-bastionhosts.id}"
    type = "ingress"
    from_port = 3128
    to_port = 3128
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.SG-backendservers.id}"
    description = "Allow Squid proxy access from backend servers"
}

resource "aws_security_group" "SG-backendservers" {
    name = "SG-backendservers"
    vpc_id = "${aws_vpc.gitlabha.id}"
    description = "Security group for backend servers"
    ingress {
        from_port = 6432
        to_port = 6432
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-frontendservers.id}"]
        description = "Allow incoming PostgreSQL traffic from frontend servers"
    }

    ingress {
       from_port = 0
       to_port = 0
       protocol = -1
       self = true
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
        description = "Allow incoming SSH traffic from bastion hosts"
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "ICMP"
        security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
        description = "Allow incoming ICMP from management IPs"
    }

     egress {
        from_port = 0
        to_port = 0
        protocol = -1
        self = true
    }

    egress {
        from_port = 3128
        to_port = 3128
        protocol = "TCP"
        security_groups = ["${aws_security_group.SG-bastionhosts.id}"]
    }
    tags = {
        Name = "SG-backendservers"
    }
}
