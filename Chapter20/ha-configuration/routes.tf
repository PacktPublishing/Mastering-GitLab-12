resource "aws_route_table" "eu-default" {
  vpc_id = "${aws_vpc.gitlabha.id}"

  route {
      cidr_block = "0.0.0.0/0" # Defines default route 
      gateway_id = "${aws_internet_gateway.inetgw.id}" # via IGW
  }

  tags = {
      Name = "Route-Table-EU-Default"
  }
}

resource "aws_route_table_association" "eu-west-1a-public" {
  subnet_id = "${aws_subnet.pub-web-az-a.id}"
  route_table_id = "${aws_route_table.eu-default.id}"
}

resource "aws_route_table_association" "eu-west-1b-public" {
  subnet_id = "${aws_subnet.pub-web-az-b.id}"
  route_table_id = "${aws_route_table.eu-default.id}"
}


resource "aws_route_table_association" "eu-west-1a-private" {
  subnet_id = "${aws_subnet.priv-db-az-a.id}"
  route_table_id = "${aws_route_table.eu-default.id}"
}

resource "aws_route_table_association" "eu-west-1b-private" {
  subnet_id = "${aws_subnet.priv-db-az-b.id}"
  route_table_id = "${aws_route_table.eu-default.id}"
}