provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "ec2-test" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  securitysecurity_groups = [var.security_groups]
}