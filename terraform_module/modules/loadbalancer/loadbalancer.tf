
# Create a Load Balancer ------------------------------------------------------
resource "aws_lb" "module_load_balancer_for_autoscale" {
  name               = var.module_load_balancer_for_autoscale_name
  internal           = false
  load_balancer_type = var.module_load_balancer_for_autoscale_type
  security_groups    = [var.http_allowed_secgroup_id]
  subnets            = [var.aws_subnet.module_subnet_1.id, var.aws_subnet.module_subnet_2.id]

  enable_deletion_protection = false
}

# Create a Load Balancer Target Group -----------------------------------------

resource "aws_lb_target_group" "module_alb_target" {
  name        = var.module_alb_target_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

# Create a Load Balancer Listener ---------------------------------------------
resource "aws_lb_listener" "module_front_end" {
  load_balancer_arn = aws_lb.module_load_balancer_for_autoscale.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.module_alb_target.arn
  }
}
