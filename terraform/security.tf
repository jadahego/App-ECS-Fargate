# security.tf

# ALB security Group: Edit to restrict access to the application
resource "aws_security_group" "sg-jdhg" {
    name        = "cb-load-balancer-security-group"
    description = "controls access to the ALB"
    vpc_id      = aws_vpc.vpc-jdhg.id

    ingress {
        protocol    = "tcp"
        from_port   = var.app_port
        to_port     = var.app_port
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks-jdhg" {
    name        = "cb-ecs-tasks-security-group"
    description = "allow inbound access from the ALB only"
    vpc_id      = aws_vpc.vpc-jdhg.id

    ingress {
        protocol        = "tcp"
        from_port       = var.app_port
        to_port         = var.app_port
        security_groups = [aws_security_group.sg-jdhg.id]
    }

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}