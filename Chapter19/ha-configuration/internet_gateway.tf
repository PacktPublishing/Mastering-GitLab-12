resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.gitlabha.id}"
  tags = {
      Name = "internet_gateway-VPC-${var.environment}-Default"
  }
}
