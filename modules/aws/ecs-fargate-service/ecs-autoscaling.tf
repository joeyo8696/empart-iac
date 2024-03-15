locals {
  service_name = (var.autoscaling_enabled ?
    (try(aws_ecs_service.ecs_fargate_service_with_autoscaling_with_load_balancer[0].name, aws_ecs_service.ecs_fargate_service_with_autoscaling_without_load_balancer[0].name)) :
  null)
}

resource "aws_appautoscaling_policy" "ecs_policy" {
  count = var.autoscaling_enabled ? 1 : 0

  name               = var.ecs_autoscaling_policy_name
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  target_tracking_scaling_policy_configuration {
    target_value = var.target_value
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
      resource_label         = var.predefined_metric_type == "ALBRequestCountPerTarget" ? "${data.aws_lb.alb_arn[0].arn_suffix}/${data.aws_lb_target_group.target_group_arn[0].arn_suffix}" : null
    }
  }
}

resource "aws_appautoscaling_target" "ecs_target" {
  count = var.autoscaling_enabled ? 1 : 0

  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.ecs_service_cluster_name}/${local.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_ecs_service" "ecs_fargate_service_with_autoscaling_with_load_balancer" {
  count = var.add_load_balancer_configuration && var.autoscaling_enabled ? 1 : 0

  name            = var.ecs_service_name
  cluster         = var.ecs_service_cluster_id
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

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_service" "ecs_fargate_service_with_autoscaling_without_load_balancer" {
  count = !var.add_load_balancer_configuration && var.autoscaling_enabled ? 1 : 0

  name            = var.ecs_service_name
  cluster         = var.ecs_service_cluster_id
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

  lifecycle {
    ignore_changes = [desired_count]
  }
}
