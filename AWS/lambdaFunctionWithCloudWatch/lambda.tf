data "archive_file" "lambda" {
  type        = "zip"
  source_file = "terraform_funciton.py"
  output_path = "terraform_funciton.zip"
}

resource "aws_lambda_function" "terraform_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "terraform_funciton.zip"
  function_name = "terraform-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "terraform_funciton.lambda_handler"
  runtime = "python3.10"
}
