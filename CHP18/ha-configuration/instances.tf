resource "aws_instance" "WEBA" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.medium"
    tags {
        Name = "${var.environment}-WEB001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.pub-web-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.WebserverSG.id}"]
}
resource "aws_instance" "WEBB" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.medium"
    tags {
        Name = "${var.environment}-WEB002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.pub-web-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.WebserverSG.id}"]
}
resource "aws_instance" "BASTIONHOSTA" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-BASTION001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.pub-web-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.bastionhostSG.id}"]
}

resource "aws_instance" "BASTIONHOSTB" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-BASTION002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.pub-web-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.bastionhostSG.id}"]
}

resource "aws_instance" "SQLA" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.large"
    tags {
        Name = "${var.environment}-SQL001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.priv-db-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DBServerSG.id}"]
}

resource "aws_instance" "SQLB" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.large"
    tags {
        Name = "${var.environment}-SQL002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.priv-db-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DBServerSG.id}"]
}

resource "aws_instance" "SQLC" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.large"
    tags {
        Name = "${var.environment}-SQL003"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.priv-db-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DBServerSG.id}"]
}


resource "aws_instance" "REDISA" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-REDIS001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.pub-web-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.WebserverSG.id}"]
}

resource "aws_instance" "REDISB" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-REDIS002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.pub-web-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.WebserverSG.id}"]
}


resource "aws_instance" "CONSULA" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-CONSUL001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.priv-db-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DBServerSG.id}"]
}

resource "aws_instance" "CONSULB" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-CONSUL002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.priv-db-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DBServerSG.id}"]
}

resource "aws_instance" "CONSULC" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-CONSUL003"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.priv-db-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DBServerSG.id}"]
}

resource "aws_instance" "PGBOUNCERA" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-PGBOUNCER001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.priv-db-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.DBServerSG.id}"]
}

resource "aws_instance" "NFSA" {
    ami = "${lookup(var.aws_ubuntu_awis,var.region)}"
    instance_type = "t2.medium"
    tags {
        Name = "${var.environment}-NFS001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.pub-web-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.WebserverSG.id}"]
}

