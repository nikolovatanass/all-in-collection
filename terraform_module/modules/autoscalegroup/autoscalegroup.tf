resource "aws_autoscaling_group" "module_auto_scale_group" {
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2
  vpc_zone_identifier = [var.subnet_id3, var.subnet_id4]
  target_group_arns = [target_group_arn]
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
}