locals {
  ecs_environment_variables_secret_arn = data.aws_secretsmanager_secret.ecs_environment_variables_secret.arn
  ecs_environment_variables            = jsondecode(data.aws_secretsmanager_secret_version.ecs_environment_variables_latest.secret_string)
  ecs_environment_variables_list = [
    for key, value in local.ecs_environment_variables :
    {
      "name"      = key
      "valueFrom" = "${local.ecs_environment_variables_secret_arn}:${key}::"
    }
  ]
}

resource "aws_ecs_task_definition" "ecs_fargate_task_definition" {
  depends_on = [aws_cloudwatch_log_group.ecs_log_group]

  family                   = var.ecs_task_definition_name
  cpu                      = var.ecs_task_unit_cpu
  memory                   = var.ecs_task_unit_memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn
  container_definitions = jsonencode([
    {
      name         = var.container_name
      image        = var.container_image
      command      = var.container_override_command
      essential    = true
      portMappings = var.port_mappings
      secrets      = local.ecs_environment_variables_list
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${var.ecs_task_definition_name}-logs"
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  tags = module.this.tags
}
