resource "aws_cloudwatch_metric_alarm" "lambda_alarm" {
  alarm_name                = "lambda-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = 30
  alarm_description         = "This metric monitors ec2 cpu utilization"
  treat_missing_data        = "breaching"
  alarm_actions = [aws_sns_topic.lambda_sns.arn]
}
