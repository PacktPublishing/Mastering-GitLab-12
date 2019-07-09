resource "aws_vpc" "gitlabha" {
  cidr_block = "10.0.0.0/16" # Defines overall VPC address space
  enable_dns_hostnames = true # Enable DNS hostnames for this VPC
  enable_dns_support = true # Enable DNS resolving support for this VPC
  tags{
      Name = "VPC-${var.environment}" # Tag VPC with name
  }
}
