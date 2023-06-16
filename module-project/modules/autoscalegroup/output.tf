output "autoscale_name" {
  value = aws_autoscaling_group.module_auto_scale_group.name
}

output "autoscale_policy_arn" {
  value = aws_autoscaling_policy.module_nginx_autoscale_policy.arn
}