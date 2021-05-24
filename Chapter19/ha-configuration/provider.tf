terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
    aws = {
      source = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}
provider "aws" {
    region  = "${var.region}"
}