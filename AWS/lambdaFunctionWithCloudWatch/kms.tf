resource "aws_kms_key" "kms_key" {
  description = "kms-key"
}

resource "aws_kms_key_policy" "kms_key_policy" {
  key_id = aws_kms_key.kms_key.id
  policy = jsonencode({
    Id = "kms-key"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
      },
    ]
    Version = "2012-10-17"
  })
}