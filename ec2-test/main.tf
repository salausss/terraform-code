provider "aws" {
  
}

module "ec2-create" {
  source = "../aws/module"
  ami = var.ami 
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_groups = var.security_groups
}