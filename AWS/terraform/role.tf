resource "aws_iam_role" "bucket" {
  name               = "bucket_role"
  assume_role_policy = data.aws_iam_policy_document.who.json
}

resource "aws_iam_role_policy" "bucket" {
  name               = "bucket_role_policy"
  policy = data.aws_iam_policy_document.rights.json
  role = aws_iam_role.bucket.id 
}



