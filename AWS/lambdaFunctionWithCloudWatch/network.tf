resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/22"
}

# Create 4 Subnets ------------------------------------------------------------
resource "aws_subnet" "terraform_sub1" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = lookup(var.cidr_ranges, "public1")
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    name = "${lookup(var.subnet_type, "public")}-subnet"
  }
}

# Create a IGW ----------------------------------------------------------------
resource "aws_internet_gateway" "terraform_gateway" {
  vpc_id = aws_vpc.terraform_vpc.id
}

# Create 4 Routing Tables -----------------------------------------------------
resource "aws_route_table" "terraform_route_gateway" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_gateway.id
  }
}

# Assosiate Routing Tables ----------------------------------------------------
resource "aws_route_table_association" "terraform_associate1" {
  subnet_id      = aws_subnet.terraform_sub1.id
  route_table_id = aws_route_table.terraform_route_gateway.id
}
