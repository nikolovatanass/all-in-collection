resource "aws_config_config_rule" "config_rule" {
  name = "config_rule"

  source {
    owner             = "AWS"
    source_identifier = "S3-BUCKET-SERVER-SIDE-ENCRYPTION-ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}