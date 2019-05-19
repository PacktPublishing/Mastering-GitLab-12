resource "aws_instance" "FRONTEND_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    subnet_id = "${aws_subnet.public-frontend_az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-frontendservers.id}"]
    instance_type = "t2.medium"
    tags {
        Name = "${var.environment}-FRONTEND001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}
resource "aws_instance" "FRONTEND_B" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    subnet_id = "${aws_subnet.public-frontend_az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-frontendservers.id}"]
    instance_type = "t2.medium"
    tags {
        Name = "${var.environment}-FRONTEND002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}
resource "aws_instance" "BASTIONHOST_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-frontend_az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-bastionhosts.id}"]
    tags {
        Name = "${var.environment}-BASTION001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "BASTIONHOST_B" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-frontend_az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-bastionhosts.id}"]
    tags {
        Name = "${var.environment}-BASTION002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "SQL_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.large"
    subnet_id = "${aws_subnet.public-backend-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags {
        Name = "${var.environment}-SQL001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "SQL_B" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.large"
    tags {
        Name = "${var.environment}-SQL002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
    subnet_id = "${aws_subnet.public-backend-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
}

resource "aws_instance" "SQL_C" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.large"
    subnet_id = "${aws_subnet.public-backend-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags {
        Name = "${var.environment}-SQL003"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "REDIS_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-frontend_az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-frontendservers.id}"]
    tags {
        Name = "${var.environment}-REDIS001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "REDIS_B" {
    subnet_id = "${aws_subnet.public-frontend_az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-frontendservers.id}"]
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    tags {
        Name = "${var.environment}-REDIS002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "CONSUL_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-backend-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags {
        Name = "${var.environment}-CONSUL001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "CONSUL_B" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-backend-az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags {
        Name = "${var.environment}-CONSUL002"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "CONSUL_C" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-backend-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags {
        Name = "${var.environment}-CONSUL003"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "PGBOUNCER_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public-backend-az-b.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-backendservers.id}"]
    tags {
        Name = "${var.environment}-PGBOUNCER001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}

resource "aws_instance" "NFS_A" {
    ami = "${lookup(var.aws_ubuntu_amis,var.region)}"
    instance_type = "t2.medium"
    subnet_id = "${aws_subnet.public-frontend_az-a.id}"
    key_name = "${aws_key_pair.keypair.key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG-frontendservers.id}"]
    tags {
        Name = "${var.environment}-NFS001"
        Environment = "${var.environment}"
        sshUser = "ubuntu"
    }
}
