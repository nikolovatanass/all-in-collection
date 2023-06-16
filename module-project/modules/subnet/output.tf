output "subnet_id1" {
  value = var.aws_subnet.module_subnet_1.id
}

output "subnet_id2" {
  value = var.aws_subnet.module_subnet_2.id
}

output "subnet_id3" {
  value = var.aws_subnet.module_subnet_3.id
}

output "subnet_id4" {
  value = var.aws_subnet.module_subnet_4.id
}

output "elip1_id1" {
  value = aws_eip.module_elip1.id
}

output "elip2_id2" {
  value = aws_eip.module_elip2.id
}

output "nat1_id" {
  value = aws_nat_gateway.module_nat1.id
}

output "nat2_id" {
  value = aws_nat_gateway.module_nat2.id
}