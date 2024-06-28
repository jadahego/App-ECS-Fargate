# ecs.tf
# Definición del cluster ECS
resource "aws_ecs_cluster" "my_ecs_cluster_jdhg" {
    name = "my_ecs_cluster_jdhg"
}

# Plantilla para la definición de la tarea ECS
data "template_file" "cb_app" {
    template = file("./ecs/task_definition.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        aws_region     = var.aws_region
    }
}

# Definición de la tarea ECS
resource "aws_ecs_task_definition" "app" {
    family                   = "cb-app-task"
    execution_role_arn       = aws_iam_role.ecs_exec_role_jdhg.arn
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.fargate_cpu
    memory                   = var.fargate_memory
    container_definitions    = data.template_file.cb_app.rendered
}

# Definición del servicio ECS
resource "aws_ecs_service" "main" {
    name            = "cb-service"
    cluster         = aws_ecs_cluster.my_ecs_cluster_jdhg.id  # Corregido: Utilizar el ID del cluster
    task_definition = aws_ecs_task_definition.app.arn
    desired_count   = var.app_count
    launch_type     = "FARGATE"

    # Configuración de red
    network_configuration {
        security_groups  = [aws_security_group.ecs_tasks-jdhg.id]
        subnets          = aws_subnet.private-jdhg-west-b.*.id
        assign_public_ip = true
    }

    # Configuración del balanceador de carga (ALB)
    load_balancer {
        target_group_arn = aws_alb_target_group.apppy.arn  # Asegurarse que el ARN del target group sea correcto
        container_name   = "cb-app"
        container_port   = var.app_port
    }

    # Dependencias
    depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_exec_role_policy]
}
