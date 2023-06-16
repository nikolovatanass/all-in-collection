# Create a Security Group -----------------------------------------------------
resource "aws_security_group" "module_allow_http_traffic" {
  name        = var.module_allow_http_traffic
  description = var.module_allow_http_traffic_description
  vpc_id      = var.vpc_id

  ingress {
    description      = var.ingress_description
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = [var.allowed_ingress_traffic]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Create a Security Group -----------------------------------------------------
resource "aws_security_group" "module_allow_filtered_traffic" {
  name        = var.module_allow_filtered_traffic_name
  description = var.module_allow_filtered_traffic_description
  vpc_id      = var.vpc_id

  ingress {
    description      = "Traffic from http_sec_group"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    security_groups = [var.http_allowed_secgroup_id] 
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
