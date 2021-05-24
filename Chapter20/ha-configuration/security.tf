resource "aws_security_group" "LoadBalancerSG" {
    name = "LoadBalancerSG"
    vpc_id = "${aws_vpc.gitlabha.id}"
    description = "Security group for load-balancers"
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
        security_groups = ["${aws_security_group.ApplicationSG.id}"]
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        security_groups = ["${aws_security_group.ApplicationSG.id}"]
    }

    tags= {
        Name = "SG-Loadbalancer"
    }
}
resource "aws_security_group" "ApplicationSG" {
    name = "ApplicationSG"
    vpc_id = "${aws_vpc.gitlabha.id}"
    description = "Security group for webservers"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.bastionhostSG.id}"]
        description = "Allow incoming SSH traffic from Bastion Host"
    }
    ingress {
      from_port = -1
      to_port = -1
      protocol = "ICMP"
      security_groups = ["${aws_security_group.bastionhostSG.id}"]
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
        security_groups = ["${aws_security_group.bastionhostSG.id}"]
    }
    egress {
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
      description = "Allow all outgoing traffic"
    }
    tags = {
        Name = "SG-WebServer"
    }
}

resource "aws_security_group" "bastionhostSG" {
  name = "BastionHostSG"
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
      Name = "SG-Bastionhost"
  }
}

resource "aws_security_group_rule" "lbhttpaccess" {
    security_group_id = "${aws_security_group.ApplicationSG.id}"
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.LoadBalancerSG.id}"
    description = "Allow Squid proxy access from loadbalancers"
}

resource "aws_security_group_rule" "lbhttpsaccess" {
    security_group_id = "${aws_security_group.ApplicationSG.id}"
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.LoadBalancerSG.id}"
    description = "Allow Squid proxy access from loadbalancers"
}

resource "aws_security_group_rule" "webproxyaccess" {
    security_group_id = "${aws_security_group.bastionhostSG.id}"
    type = "ingress"
    from_port = 3128
    to_port = 3128
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.ApplicationSG.id}"
    description = "Allow Squid proxy access from webservers"
}

resource "aws_security_group_rule" "dbproxyaccess" {
    security_group_id = "${aws_security_group.bastionhostSG.id}"
    type = "ingress"
    from_port = 3128
    to_port = 3128
    protocol = "TCP"
    source_security_group_id = "${aws_security_group.DBServerSG.id}"
    description = "Allow Squid proxy access from database servers"
}

resource "aws_security_group" "DBServerSG" {
    name = "DBServerSG"
    vpc_id = "${aws_vpc.gitlabha.id}"
    description = "Security group for database servers"
    ingress {
        from_port = 6432
        to_port = 6432
        protocol = "TCP"
        security_groups = ["${aws_security_group.ApplicationSG.id}"]
        description = "Allow incoming PostgreSQL traffic from webservers"
    }

    ingress {
       from_port = 0
       to_port = 0
       protocol = -1
       self = true
    }

    # ingress {
    #     from_port = 5432
    #     to_port = 5432
    #     protocol = "TCP"
    #     security_groups = ["${aws_security_group.bastionhostSG.id}"]
    #     description = "Allow incoming PostgreSQL traffic from Bastion Host"
    # }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        security_groups = ["${aws_security_group.bastionhostSG.id}"]
        description = "Allow incoming SSH traffic from Bastion Host"
    }
    
    ingress {
        from_port = -1
        to_port = -1
        protocol = "ICMP"
        security_groups = ["${aws_security_group.bastionhostSG.id}"]
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
        security_groups = ["${aws_security_group.bastionhostSG.id}"]
    }
    tags = {
        Name = "SG-DBServer"
    }
}