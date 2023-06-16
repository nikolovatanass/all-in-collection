resource "aws_subnet" "module_subnet_1" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block1
  availability_zone = var.availability_zone1
}

resource "aws_subnet" "module_subnet_2" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block2
  availability_zone = var.availability_zone2
}

resource "aws_subnet" "module_subnet_3" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block1
  availability_zone = var.availability_zone1
}

resource "aws_subnet" "module_subnet_4" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block2
  availability_zone = var.availability_zone2
}

resource "aws_route_table_association" "module_associate1" {
  subnet_id      = var.subnet_id1
  route_table_id = var.route_gateway_table_id
}

resource "aws_route_table_association" "module_associate2" {
  subnet_id      = var.subnet_id2
  route_table_id = var.route_gateway_table_id
}

# Create 2 ElasticIP ---------------------------------------------------------
resource "aws_eip" "module_elip1" {
  domain = "vpc"
}

resource "aws_eip" "module_elip2" {
  domain = "vpc"
}

# Create 2 NAT Gateway --------------------------------------------------------
resource "aws_nat_gateway" "module_nat1" {
  allocation_id = var.elip1_id1
  subnet_id     = var.subnet_id1
}

resource "aws_nat_gateway" "module_nat2" {
  allocation_id = var.elip2_id2
  subnet_id     = var.subnet_id2
}

# NAT Route Tables ------------------------------------------------------------
resource "aws_route_table" "route_nat" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat1_id
  }
}

resource "aws_route_table" "route_nat2" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat2_id
  }
}

# Subnet to NAT ---------------------------------------------------------------

resource "aws_route_table_association" "module_associate3" {
  subnet_id      = var.subnet_id3
  route_table_id = var.route_nat
}

resource "aws_route_table_association" "module_associate4" {
  subnet_id      = var.subnet_id4
  route_table_id = var.route_nat2
}