resource "aws_alb" "alb-jdhg" {
  name            = "cb-load-balancer"
  subnets         = aws_subnet.public-jdhg-west-b.*.id
  security_groups = [aws_security_group.sg-jdhg.id]
}

resource "aws_alb_target_group" "apppy" {
  name        = "cb-target-group"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.vpc-jdhg.id
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = 3
    path                = var.health_check_path
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.alb-jdhg.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:region:account-id:certificate/certificate-id"

  default_action {
    target_group_arn = aws_alb_target_group.apppy.arn
    type             = "forward"
  }
}
