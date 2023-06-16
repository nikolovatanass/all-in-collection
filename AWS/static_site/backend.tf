terraform {
  backend "s3" {
    bucket         = "terafform-backend-original-unique873495"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    # dynamodb_table = "terraform-state-lock-dynamo"
  }
}