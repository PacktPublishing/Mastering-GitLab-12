resource "aws_vpc" "gitlabha" {
  cidr_block = "10.0.0.0/16" # Defines overall VPC address space
  enable_dns_hostnames = true # Enable DNS hostnames for this VPC
  enable_dns_support = true # Enable DNS resolving support for this VPC
  tags = {
      Name = "VPC-${var.environment}" # Tag VPC with name
  }
}

resource "aws_subnet" "pub-web-az-a" {
  availability_zone = "eu-west-1a" # Define AZ for subnet
  cidr_block = "10.0.11.0/24" # Define CIDR-block for subnet
  map_public_ip_on_launch = true # Map public IP to deployed instances in this VPC
  vpc_id = "${aws_vpc.gitlabha.id}" # Link Subnet to VPC
  tags = {
      Name = "Subnet-EU-West-1a-Web" # Tag subnet with name
  }
}

resource "aws_subnet" "pub-web-az-b" {
  availability_zone = "eu-west-1b"
  cidr_block = "10.0.12.0/24"
  map_public_ip_on_launch = true
  vpc_id = "${aws_vpc.gitlabha.id}"
  tags = {
    Name = "Subnet-EU-West-1b-Web"
  }
}

resource "aws_subnet" "priv-db-az-a" {
  availability_zone = "eu-west-1a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = false
  vpc_id = "${aws_vpc.gitlabha.id}"
  tags = {
      Name = "Subnet-EU-West-1a-DB"
  }
}

resource "aws_subnet" "priv-db-az-b" {
  availability_zone = "eu-west-1b"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  vpc_id = "${aws_vpc.gitlabha.id}"
  tags = {
    Name = "Subnet-EU-West-1b-DB"
  }
}

resource "aws_internet_gateway" "inetgw" {
  vpc_id = "${aws_vpc.gitlabha.id}"
  tags = {
      Name = "IGW-VPC-${var.environment}-Default"
  }
}
