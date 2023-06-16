# Create a Launch Configuration -----------------------------------------------
resource "aws_launch_template" "module_nginx_auto_scale" {
  name_prefix            = var.template_name
  image_id               = var.aws_ami
  instance_type          = var.instance_type
  iam_instance_profile {
    name = var.insance_profile_name
  }
}