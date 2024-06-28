[
  {
    "name": "cb-app",
    "image": "132972109843.dkr.ecr.us-west-2.amazonaws.com/cb-app",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/cb-app",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]


