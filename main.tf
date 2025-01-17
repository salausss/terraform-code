resource "aws_vpc" "test" {
   cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "test_subnet1" {
   cidr_block = "10.0.0.0/24"
   vpc_id =  aws_vpc.test.id
   map_public_ip_on_launch = true
   tags = {
        name = "test_subnet1"
   }
}

resource "aws_subnet" "test_subnet2" {
  vpc_id = aws_vpc.test.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    name = "test_subnet2"
  }
}


resource "aws_internet_gateway" "igt" {
  vpc_id = aws_vpc.test.id
  tags = {
     name = "igt"
  }
}

resource "aws_route_table" "test_table" {
  vpc_id = aws_vpc.test.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igt.id
  }
  tags = {
    name = "test_table"
  }
}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.test_subnet1.id
    route_table_id = aws_route_table.test_table.id

}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.test_subnet2.id
  route_table_id = aws_route_table.test_table.id 
}

resource "aws_security_group" "sg1" {
  vpc_id = aws_vpc.test.id
  name = "sg1"
  
  ingress  {
    description = "http to vpc"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh conn"
    protocol = "tcp"
    to_port = 22
    from_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbound"
    to_port = 443
    from_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "sg1"
  }

}

resource "aws_s3_bucket" "test_bucket_salah_0001" {
    bucket = "test_bucket_salah_0001"
    tags = {
      name = "test_bucket_salah_0001"

    }

}

resource "aws_instance" "test1" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["aws_security_group.sg1"]
  subnet_id = ["aws_subnet.test_subnet1.id"]
  user_data = fileexists("testscript.sh") ? base64encode(file("testscript.sh")) : ""
}

