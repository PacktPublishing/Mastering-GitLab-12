variable "region" {
    default = "eu-west-1"
}

variable "aws_ubuntu_awis" {
    default = {
        "eu-west-1" = "ami-2a7d75c0"
    }
}

variable "environment"{
    type = string
    default = "dev"
}

variable "application" {
    type = string
    default = "gitlab"
}

variable "key_name" {
    type = string
    default = "ec2key"
}

variable "mgmt_ips" {
    default = ["0.0.0.0/0"]
}
