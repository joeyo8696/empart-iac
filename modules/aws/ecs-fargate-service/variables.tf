variable "environment" {
  description = "the environment that the code will be deployed it"
  type        = string
}

variable "region" {
  description = "the AWS region that the module will be deployed in"
  type        = string
}

variable "vpc_id" {
  description = "the vpc id that the service will get deployed in"
  type        = string
}

### ECS Service
variable "ecs_service_name" {
  description = "the name of the ecs service"
  type        = string
}

variable "ecs_service_cluster_id" {
  description = "the ID for the cluster the ECS service should get attached to"
  type        = string
}


variable "ecs_service_task_count" {
  description = "the number of instances of the task definition to place and keep running"
  type        = number
}

variable "ecs_service_security_groups" {
  description = "a list of security group ids that will be associated with the ecs service/ task"
  type        = list(string)
}

variable "ecs_service_registry_arn" {
  description = "the arn of the service registry"
  type        = string
}

variable "add_load_balancer_configuration" {
  description = "True if the service will have a load balancer configured. False if the service will not have a load balancer configured"
  type        = bool
  default     = false
}

variable "ecs_target_group_config" {
  description = "the configuration for the target group instances will get registered to. Required when add_load_balancer_configuration is true"
  type = object({
    target_group_arn  = string
    target_group_name = string
  })
  default = {
    target_group_arn  = ""
    target_group_name = ""
  }
}

variable "ecs_alb_config" {
  description = "the alb configuration the target group is associated with. Required when autoscaling_enabled is true and predefined_metric_type is ALBRequestCountPerTarget"
  type = object({
    alb_arn  = string
    alb_name = string
  })
  default = {
    alb_arn  = ""
    alb_name = ""
  }
}

### ECS Task
variable "ecs_task_definition_name" {
  description = "the name of the task definition"
  type        = string
}

variable "ecs_task_unit_cpu" {
  description = "the number of cpu units used by the task"
  type        = number
}

variable "ecs_task_unit_memory" {
  description = "the amount of memory used by the task"
  type        = number
}

variable "ecs_task_execution_role_arn" {
  description = "the arn of the task execution role that the amazon ecs container agent and docker daemon can assume"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "the arn of the role that allows your amazon ecs container to make calls to other aws resources"
  type        = string
}

## Container Configuration
variable "container_name" {
  description = "the name of the container"
  type        = string
}

variable "container_image" {
  description = "the image used to start a container"
  type        = string
}

variable "container_override_command" {
  description = "the command used to start the container. This command overrides the image command."
  type        = list(string)
  default     = []
}

variable "container_port" {
  description = "the port on the container to associate the load balancer"
  type        = number
  default     = 0
}

variable "port_mappings" {
  description = "the list of port mappings for the container"
  type        = list(any)
}

variable "ecs_environment_variable_secret_name" {
  description = "the name of the secret in aws secrets manager that contains the environmet variables for the containers"
  type        = string
}

### Autoscaling
variable "autoscaling_enabled" {
  description = "a boolean to enable or disable autoscaling"
  type        = bool
  default     = false
}

variable "ecs_autoscaling_policy_name" {
  description = "the name of the policy"
  type        = string
  default     = null
}

variable "target_value" {
  description = "target value for the metric"
  type        = number
  default     = null
}

variable "predefined_metric_type" {
  description = "the metric type"
  type        = string
  default     = "ALBRequestCountPerTarget"
  validation {
    condition     = contains(["ECSServiceAverageCPUUtilization", "ECSServiceAverageMemoryUtilization", "ALBRequestCountPerTarget"], var.predefined_metric_type)
    error_message = "Valid values for predefined_metric_type: ECSServiceAverageCPUUtilization, ECSServiceAverageMemoryUtilization, ALBRequestCountPerTarget."
  }
}

variable "max_capacity" {
  description = "maximum capacity of the scalable target"
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "minimum capacity of the scalable target"
  type        = number
  default     = null
}

variable "ecs_service_cluster_name" {
  description = "the name of the ECS cluster auto scaling will be enabled for. Required when autoscaling_enabled is true"
  type        = string
  default     = ""
}
