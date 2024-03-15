data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "Private"
  }
}

data "aws_secretsmanager_secret" "ecs_environment_variables_secret" {
  name = var.ecs_environment_variable_secret_name
}

data "aws_secretsmanager_secret_version" "ecs_environment_variables_latest" {
  secret_id = data.aws_secretsmanager_secret.ecs_environment_variables_secret.id
}

data "aws_lb" "alb_arn" {
  count = var.autoscaling_enabled && var.predefined_metric_type == "ALBRequestCountPerTarget" ? 1 : 0
  name  = var.ecs_alb_config.alb_name
  arn   = var.ecs_alb_config.alb_arn
}

data "aws_lb_target_group" "target_group_arn" {
  count = var.add_load_balancer_configuration || var.autoscaling_enabled ? 1 : 0
  name  = var.ecs_target_group_config.target_group_name
  arn   = var.ecs_target_group_config.target_group_arn
}
