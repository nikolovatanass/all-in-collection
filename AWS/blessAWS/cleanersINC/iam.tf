# Creating IAM role -----------------------------------------------------------
resource "aws_iam_role" "code_build_rights" {
  name = "code-build-role-3"
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
  role       = aws_iam_role.code_build_rights.id
  policy_arn = var.code_build_policy


}

# Creating event to code build ------------------------------------------------
resource "aws_iam_role" "code_build_role_events" {
  name = "code-build-role4"
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