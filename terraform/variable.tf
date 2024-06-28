variable "aws_region" { 
    description = "The AWS region to deploy in"
    default     = "us-west-2"
} 

variable "ec2_task_execution_role_name" { 
    description = "nombre del rol de ejecución de tareas de ECS" 
    default = "Bbog-myEcsTaskExecutionRole-JDHG"
} 

variable "ecs_auto_scale_role_name" { 
    description = "nombre del rol de escala automática de ECS" 
    default = "Bbog-myEcsAutoScaleRole-JDHG"
} 

variable "az_count" { 
    description = "Número de AZ para cubrir en una región determinada" 
    default = "2"
} 

variable "app_image" { 
    description = "Imagen de Docker para ejecutar en el clúster ECS" 
    default = "132972109843.dkr.ecr.us-west-2.amazonaws.com/cb-app"
} 

variable "app_port" { 
    description = "Puerto expuesto por la imagen de la ventana acoplable para redirigir el tráfico a" 
    default = 3000
} 

variable "app_count" { 
    description = "Número de contenedores de la ventana acoplable para ejecutar" 
    default = 3
} 

variable "health_check_path" { 
    default = "/"
} 

variable "fargate_cpu" { 
    description = "Unidades de CPU de instancia de Fargate para aprovisionar (1 vCPU = 1024 unidades de CPU)" 
    default = "1024"
} 

variable "fargate_memory" { 
    description = "Memoria de instancia de Fargate para aprovisionar (en MiB)" 
    default = "512"
}
