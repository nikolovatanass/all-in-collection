resource "aws_cloudwatch_event_rule" "event_bridge_rule" {
  name        = "event-bridge-team"
  description = "Capture each AWS Console Sign In"
  schedule_expression = "cron(0 20 * * ? *)"
}

resource "aws_cloudwatch_event_target" "sns_event_watch_target" {
  rule      = aws_cloudwatch_event_rule.event_bridge_rule.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_sns_topic_logins.arn # Replace with codebuildjob
}

resource "aws_sns_topic" "aws_sns_topic_logins" {
  name = "aws-sns-topic-logins"
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.aws_sns_topic_logins.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json #change later
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sns_topic.aws_sns_topic_logins.arn]
  }
}
