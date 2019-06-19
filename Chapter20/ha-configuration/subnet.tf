resource "aws_subnet" "public-frontend_az-a" {
  availability_zone = "eu-central-1a" 
  cidr_block = "10.0.11.0/24" 
  map_public_ip_on_launch = true 
  vpc_id = "${aws_vpc.gitlabha.id}" #
  tags {
      Name = "Subnet-eu-central-1a-Frontend" 
  }
}

resource "aws_subnet" "public-frontend_az-b" {
    availability_zone = "eu-central-1b"
    cidr_block = "10.0.12.0/24"
    map_public_ip_on_launch = true
    vpc_id = "${aws_vpc.gitlabha.id}"
      tags {
      Name = "Subnet-eu-central-1b-Frontend"
  }
}

resource "aws_subnet" "public-backend-az-a" {
  availability_zone = "eu-central-1a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = false
  vpc_id = "${aws_vpc.gitlabha.id}"
  tags {
      Name = "Subnet-eu-central-1a-DB"
  }
}

resource "aws_subnet" "public-backend-az-b" {
    availability_zone = "eu-central-1b"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = false
    vpc_id = "${aws_vpc.gitlabha.id}"
      tags {
      Name = "Subnet-eu-central-1b-DB"
  }
}
