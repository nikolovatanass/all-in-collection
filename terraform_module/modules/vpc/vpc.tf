resource "aws_vpc" "module_created_vpc" {
  cidr_block = var.cidr_block
}

resource "aws_internet_gateway" "module_gateway" {
  vpc_id = var.vpc_id
}

resource "aws_route_table" "module_route_gateway" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
}