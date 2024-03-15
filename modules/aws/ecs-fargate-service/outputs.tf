output "ecs_service_cluser_arn" {
  description = "the arn of the cluster which the service runs on"
  value = try(
    aws_ecs_service.ecs_fargate_service_with_load_balancer[0].cluster,
    aws_ecs_service.ecs_fargate_service_without_load_balancer[0].cluster,
    aws_ecs_service.ecs_fargate_service_with_autoscaling_with_load_balancer[0].cluster,
    aws_ecs_service.ecs_fargate_service_with_autoscaling_without_load_balancer[0].cluster
  )
}

output "ecs_service_id" {
  description = "the service arn"
  value = try(
    aws_ecs_service.ecs_fargate_service_with_load_balancer[0].id,
    aws_ecs_service.ecs_fargate_service_without_load_balancer[0].id,
    aws_ecs_service.ecs_fargate_service_with_autoscaling_with_load_balancer[0].id,
    aws_ecs_service.ecs_fargate_service_with_autoscaling_without_load_balancer[0].id
  )
}

output "ecs_service_name" {
  description = "the name of the service"
  value = try(
    aws_ecs_service.ecs_fargate_service_with_load_balancer[0].name,
    aws_ecs_service.ecs_fargate_service_without_load_balancer[0].name,
    aws_ecs_service.ecs_fargate_service_with_autoscaling_with_load_balancer[0].name,
    aws_ecs_service.ecs_fargate_service_with_autoscaling_without_load_balancer[0].name
  )
}

output "ecs_task_arn" {
  description = "the arn of the task"
  value       = aws_ecs_task_definition.ecs_fargate_task_definition.arn
}

output "ecs_task_revision" {
  description = "revision of the task in a particular family"
  value       = aws_ecs_task_definition.ecs_fargate_task_definition.revision
}
