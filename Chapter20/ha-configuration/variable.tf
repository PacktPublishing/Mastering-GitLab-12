variable "region"
{
    default = "eu-central-1"
}

variable "aws_ubuntu_amis"
{
    default = {
        "eu-central-1" = "ami-0f041b9708f60ca57"
    }
}

variable "environment"{
    type = "string"
    default = "dev"
}

variable "application" {
    type = "string"
    default = "gitlab"
}

#variable "key_name" {
#    type = "string"
#    #default = "ec2key"
#}

variable "mgmt_ips" {
    default = ["0.0.0.0/0"]
}
