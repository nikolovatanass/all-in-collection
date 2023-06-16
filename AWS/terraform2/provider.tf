provider "aws" {
  region  = "eu-west-1"
}

data "aws_vpc" "default"{
    default = true
}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_launch_template" "template" {
  name = "template"
  image_id = "ami-04f7efe62f419d9f5"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0839156b1db603b9a"]
  
}

resource "aws_autoscaling_group" "group" {
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  
  vpc_zone_identifier  = data.aws_subnets.example.ids
  launch_template {
    id      = aws_launch_template.template.id
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}