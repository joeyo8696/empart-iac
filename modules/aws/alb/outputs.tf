output "target_group_arn" {
  description = "the arn of the target group"
  value       = aws_lb_target_group.default.arn
}

output "target_group_name" {
  description = "the name of the target group"
  value       = aws_lb_target_group.default.name
}

output "application_load_balancer_arn" {
  description = "the arn of the application load balancer"
  value       = module.alb.alb_arn
}

output "application_load_balancer_dns" {
  description = "the dns name of the application load balancer"
  value       = module.alb.alb_dns_name
}

output "application_load_balancer_zone_id" {
  description = "the zone id of the application load balancer"
  value       = module.alb.alb_zone_id
}

output "application_load_balancer_security_group_id" {
  description = "the id of the security group attached to the application load balancer"
  value       = module.alb.security_group_id
}

output "application_load_balancer_name" {
  description = "the name of the application load balancer"
  value       = module.alb.alb_name
}
