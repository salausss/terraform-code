variable "ami" {
    default = "ami-00bb6a80f01f03502"
    type = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {
  description = "no des"
  default = "subnet-0b3c797ff63722957"
}

variable "security_groups" {
  description = "this "
  default = "sg-0cab2d96c1e98f4c7"
}