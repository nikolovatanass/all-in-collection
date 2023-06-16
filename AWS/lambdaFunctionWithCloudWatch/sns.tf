resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.terraform_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.lambda_sns.arn
}

resource "aws_sns_topic_policy" "uswr_update_topic_policy" {
  arn    = aws_sns_topic.lambda_sns.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic" "lambda_sns" {
  name = "start-lambda"
  kms_master_key_id = aws_kms_key.kms_key.key_id
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.lambda_sns.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.terraform_lambda.arn
}

resource "aws_sns_topic_subscription" "lambda_email" {
  topic_arn = aws_sns_topic.lambda_sns.arn
  protocol  = "email"
  endpoint  = "atanas_nikolov@flutterint.com"
}

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