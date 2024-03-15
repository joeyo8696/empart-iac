resource "aws_ecs_service" "ecs_fargate_service_with_load_balancer" {
  count = var.add_load_balancer_configuration && !var.autoscaling_enabled ? 1 : 0

  name            = var.ecs_service_name
  cluster         = var.ecs_service_cluster_id
  desired_count   = var.ecs_service_task_count
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.ecs_fargate_task_definition.arn

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 15
  scheduling_strategy                = "REPLICA"

  force_new_deployment = true

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups  = var.ecs_service_security_groups
    subnets          = data.aws_subnets.private.ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.ecs_target_group_config.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  service_registries {
    registry_arn = var.ecs_service_registry_arn
  }

  tags = {
    ecs_service_name = var.ecs_service_name
    environment      = var.environment
  }
}

resource "aws_ecs_service" "ecs_fargate_service_without_load_balancer" {
  count = !var.add_load_balancer_configuration && !var.autoscaling_enabled ? 1 : 0

  name            = var.ecs_service_name
  cluster         = var.ecs_service_cluster_id
  desired_count   = var.ecs_service_task_count
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.ecs_fargate_task_definition.arn

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 15
  scheduling_strategy                = "REPLICA"

  force_new_deployment = true

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups  = var.ecs_service_security_groups
    subnets          = data.aws_subnets.private.ids
    assign_public_ip = false
  }

  service_registries {
    registry_arn = var.ecs_service_registry_arn
  }

  tags = {
    ecs_service_name = var.ecs_service_name
    environment      = var.environment
  }
}
