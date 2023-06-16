# Creating IAM role -----------------------------------------------------------
resource "aws_iam_role" "code_build" {
  name = "code-build-role-2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
            "Service"="codebuild.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    name = "role"
  }
}

# Attaching instance policy to role -------------------------------------------
resource "aws_iam_role_policy_attachment" "code_build_attach" {
  role       = aws_iam_role.code_build.id
  policy_arn = var.code_build_policy
}

