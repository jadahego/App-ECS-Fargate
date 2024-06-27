# ecs.tf

resource "aws_ecs_cluster" "my_ecs_cluster_jdhg" {
    name = "my_ecs_cluster_jdhg"
}

data "template_file" "cb_app" {
    template = file("./ecs/tak_definition.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        aws_region     = var.aws_region
    }
}

resource "aws_ecs_task_definition" "app" {
    family                   = "cb-app-task"
    execution_role_arn       = aws_iam_role.ecs_exec_role_jdhg.arn
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.fargate_cpu
    memory                   = var.fargate_memory
    container_definitions    = data.template_file.cb_app.rendered
}

resource "aws_ecs_service" "main" {
    name            = "cb-service"
    cluster         = aws_ecs_cluster.my_ecs_cluster_jdhg.id
    task_definition = aws_ecs_task_definition.app.arn
    desired_count   = var.app_count
    launch_type     = "FARGATE"

    network_configuration {
        security_groups  = [aws_security_group.ecs_tasks-jdhg.id]
        subnets          = aws_subnet.private-jdhg-west-b.*.id
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = aws_alb_target_group.apppy.id
        container_name   = "cb-app"
        container_port   = var.app_port
    }

    depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
}