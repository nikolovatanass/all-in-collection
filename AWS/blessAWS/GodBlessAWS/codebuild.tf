resource "aws_codebuild_project" "coldbuild_demo" {
  name          = "aws-coldbuild-test"
  service_role  = aws_iam_role.codebuild.arn
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"

  }
  source {
    type            = "NO_SOURCE"
    buildspec       = file("${path.module}/buildspec.yml")
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "codebuild"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.codebuild.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_cloudwatch_event_target" "role_cloudwatch" {
  rule      = aws_cloudwatch_event_rule.event_bridge_rule.name
  target_id = aws_codebuild_project.coldbuild_demo.name
  arn       = aws_codebuild_project.coldbuild_demo.arn
  role_arn = aws_iam_role.code_build.arn
}

resource "aws_iam_role" "code_build_role" {
  name = "code-build-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
             "Service"="events.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    name = "role"
  }
}
