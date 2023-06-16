data "aws_iam_policy_document" "sns_topic_policy" {


  statement {
    effect = "Allow"
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }
    resources = [
      aws_sns_topic.lambda_sns.arn
    ]
  }
}

resource "aws_sns_topic_policy" "email_update_topic_policy" {
  arn    = aws_sns_topic.scale_sns.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic" "scale_sns" {
  name = "start-scaling"
}

resource "aws_sns_topic_subscription" "scale_email" {
  topic_arn = aws_sns_topic.scale_sns.arn
  protocol  = "email"
  endpoint  = "atanas_nikolov@flutterint.com"
}

