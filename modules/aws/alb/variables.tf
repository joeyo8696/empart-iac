# Required Variables
variable "app_name" {
  description = "the name of the application the resource will be part of"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "the arn of the ssl certificate to attach to the application load balancer"
  type        = string
}

variable "vpc_id" {
  description = "the vpc id that the service will get deployed in"
  type        = string
}

# Optional Variables
variable "is_internal" {
  description = "true if the application load balancer is internal. False if the application load balancer is internet facing"
  type        = bool
  default     = true
}

variable "taregt_groups" {
  description = "list of target groups to attach to the application load balancer"
  type = map(object({
    port = number
    health_check = object({
      healthy_threshold   = optional(number, 2)
      interval            = optional(number, 15)
      matcher             = optional(string, "200-399")
      path                = optional(string, "/")
      unhealthy_threshold = optional(number, 2)
    })
    load_balancing_algorithm_type = optional(string, "round_robin")
    protocol                      = optional(string, "HTTPS")
    tyarget_type                  = optional(string, "instance")
  }))
  default = {}
}

variable "listeners" {
  description = "list of listeners to attach to the application load balancer"
  type = map(object({
    port        = number
    alpn_policy = optional(string, "HTTP2Preferred")
    protocol    = optional(string, "HTTPS")
    ssl_policy  = optional(string, "ELBSecurityPolicy-TLS13-1-2-2021-06")
  }))
  default = {}
}












# Optional Variables
variable "alb_route53_alias" {
  description = "the route 53 entry for the application load balancer. Required when create_route53_alias is true."
  type        = string
  default     = ""
}

variable "create_route53_alias" {
  description = "a boolean flag to create a route53 alias record for the application load balancer."
  type        = bool
  default     = false
}

variable "alb_ingress_cidr_blocks" {
  description = "list of CIDR blocks to allow in security group"
  type        = list(string)
  default     = []
}

variable "http_port" {
  description = "the port for the HTTP listener"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "the port for the HTTPS listener"
  type        = number
  default     = 443
}

variable "route53_parent_zone_id" {
  description = "ID of the hosted zone to contain this record. Required when create_route53_alias is true."
  type        = string
  default     = ""
}
