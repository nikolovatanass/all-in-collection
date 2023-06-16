output "http_allowed_secgroup_id" {
  value = var.aws_security_group.module_allow_http_traffic.id
}
