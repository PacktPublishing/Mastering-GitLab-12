variable "region" {
  description = "Which Amazon region this instance will run"
}
variable "instance_type" {
  description = "Which type of Amazon EC2 instance to use"
}
variable "aws_ubuntu_amis"
{
    description = "List of default AMI images per region"
    default = {
        "eu-central-1" = "ami-0f041b9708f60ca57"
        "us-west-2" = "ami-0e63f50857fdc1f9f"
    }
}
variable "mgmt_ips" {
    default = ["0.0.0.0/0"]
}
variable "subnet_frontend_cidr_block" {
  description = "Which network range to use"
}
variable "vpc_cidr_block" {
  description = "Which network range to use"
} 
 