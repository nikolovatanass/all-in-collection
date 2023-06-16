data "aws_iam_policy_document" "rights" {
  statement {

    actions = [
      "s3:GetObject",
      "s3:Describe*",
      "s3:Lists*"
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "who" {
  statement {

    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = ["arn:aws:sts::966917725741:assumed-role/AWSReservedSSO_AWSAdministratorAccessLockedTags_6edfeed3b9d6d719/atanas_nikolov@flutterint.com"]
    }
  }
}
