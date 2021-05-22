resource "aws_route_table" "default" {
  vpc_id = "${aws_vpc.gitlabha.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags = {
      Name = "Default route table"
  }
}

resource "aws_route_table_association" "eu-central-1a-public" {
  subnet_id = "${aws_subnet.public-frontend_az-a.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_route_table_association" "eu-central-1b-public" {
  subnet_id = "${aws_subnet.public-frontend_az-b.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_route_table_association" "eu-central-1a-private" {
  subnet_id = "${aws_subnet.public-backend-az-a.id}"
  route_table_id = "${aws_route_table.default.id}"
}

resource "aws_route_table_association" "eu-central-1b-private" {
  subnet_id = "${aws_subnet.public-backend-az-b.id}"
  route_table_id = "${aws_route_table.default.id}"
}