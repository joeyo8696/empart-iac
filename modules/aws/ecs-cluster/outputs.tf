output "ecs_cluster_arn" {
  description = "the arn of the cluster created"
  value       = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_cluster_id" {
  description = "the arn of the cluster created"
  value       = aws_ecs_cluster.ecs_cluster.id
}

output "ecs_cluster_name" {
  description = "the name of the cluster created"
  value       = aws_ecs_cluster.ecs_cluster.name
}
