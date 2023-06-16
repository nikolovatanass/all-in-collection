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

resource "aws_autoscaling_policy" "module_nginx_autoscale_policy" {
  name                   = "scale-by-one"
  scaling_adjustment     = 1
  adjustment_type        = lookup(var.auto_scale_policy_type, "policy_type")
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.module_auto_scale_group.name
}

# Attach Policy ---------------------------------------------------------------
resource "aws_autoscaling_attachment" "asg_attachment_lb" {
  autoscaling_group_name = aws_autoscaling_group.module_auto_scale_group.id
  lb_target_group_arn = var.target_group_arn
}