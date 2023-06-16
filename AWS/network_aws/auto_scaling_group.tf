# Create a Launch Configuration -----------------------------------------------
resource "aws_launch_template" "the_launch_template" {
  name_prefix            = "terraform"
  image_id               = var.aws_ami
  instance_type          = lookup(var.instance_type, "instance")
  update_default_version = true
  iam_instance_profile {
    name = aws_iam_instance_profile.iam_instance_profile.name
   }
  tags = {
      Name =  "the-launch-template"
  }
   
  vpc_security_group_ids = [aws_security_group.allow_sec1.id]

  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    amazon-linux-extras install -y nginx1
    systemctl enable nginx --now
    EOF
  )
}

# Create a ASG ----------------------------------------------------------------
resource "aws_autoscaling_group" "auto_scale_group" {
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2
  vpc_zone_identifier = [aws_subnet.terraform_sub3.id, aws_subnet.terraform_sub4.id]
target_group_arns = [ aws_lb_target_group.alb-target.arn ]
  launch_template {
    id      = aws_launch_template.the_launch_template.id
    version = "$Latest"
  }
}

# Create Auto Scale Policy ----------------------------------------------------

resource "aws_autoscaling_policy" "the_autoscale_policy" {
  name                   = "the-autoscale-policy"
  scaling_adjustment     = 1
  adjustment_type        = lookup(var.auto_scale_policy_type, "policy_type")
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.auto_scale_group.name
}

# Cloudwatch configuaration ---------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "autoscale_alarm" {
  alarm_name                = lookup(var.cloudwatch_alarm, "alarm_name")
  comparison_operator       = lookup(var.cloudwatch_alarm, "comparison")
  evaluation_periods        = 1
  metric_name               = lookup(var.cloudwatch_alarm, "metric_name")
  namespace                 = lookup(var.cloudwatch_alarm, "name_space")
  period                    = 60
  statistic                 = lookup(var.cloudwatch_alarm, "statistic")
  threshold                 = 30
  alarm_description         = lookup(var.cloudwatch_alarm, "description")
  alarm_actions = [aws_autoscaling_policy.the_autoscale_policy.arn]
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.auto_scale_group.name

  }
}

# Attach Policy ---------------------------------------------------------------
resource "aws_autoscaling_attachment" "asg_attachment_lb" {
  autoscaling_group_name = aws_autoscaling_group.auto_scale_group.id
  lb_target_group_arn = aws_lb_target_group.alb-target.arn
}
