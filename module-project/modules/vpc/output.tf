output "vpc_id" {
    value = aws_vpc.module_created_vpc.id
}

output "gateway_id" {
    value = aws_internet_gateway.module_gateway.id
}

output "route_gateway_table_id" {
  value = aws_route_table.module_route_gateway.id
}