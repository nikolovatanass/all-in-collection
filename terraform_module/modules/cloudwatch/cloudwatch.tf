# Cloudwatch configuaration ---------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "module_autoscale_alarm" {
  alarm_name                = var.cloudwatch_alarm_name
  comparison_operator       = var.comparison_operator
  evaluation_periods        = 1
  metric_name               = var.name_metric
  namespace                 = var.namespace_choice
  period                    = 60
  statistic                 = var.statisctics
  threshold                 = 80
  alarm_description         = var.alarm_description
  alarm_actions = [aws_autoscaling_policy.nginx_autoscale_policy.arn]
  dimensions = {
    "AutoScalingGroupName" = var.autoscale_name
  }
}