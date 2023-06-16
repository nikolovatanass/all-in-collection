resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "example"
  role_arn = aws_iam_role.config_role.arn
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "config_role" {
  name               = "awsconfig-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "p" {
  statement {
    effect    = "Allow"
    actions   = ["config:Put*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "p" {
  name   = "my-awsconfig-policy"
  role   = aws_iam_role.config_role.id
  policy = data.aws_iam_policy_document.p.json
}