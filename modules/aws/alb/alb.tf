module "alb" {
  source  = "cloudposse/alb/aws"
  version = "1.11.1"
  # https://registry.terraform.io/modules/cloudposse/alb/aws/1.11.1

  name                              = var.app_name
  access_logs_enabled               = true
  allow_ssl_requests_only           = true
  certificate_arn                   = var.ssl_certificate_arn
  context                           = module.this.context
  cross_zone_load_balancing_enabled = true
  default_target_group_enabled      = false
  enable_glacier_transition         = true
  internal                          = var.is_internal
  ip_address_type                   = "ipv4"
  security_group_enabled            = true
  subnet_ids                        = var.is_internal ? data.aws_subnets.private.ids : data.aws_subnets.public.ids
  vpc_id                            = var.vpc_id
}

resource "aws_lb_target_group" "target_group" {
  for_each = var.taregt_groups

  health_check {
    healthy_threshold   = each.value.health_check.healthy_thresholdå
    interval            = each.value.health_check.interval
    matcher             = each.value.health_check.matcher
    path                = each.value.health_check.path
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
  }
  load_balancing_algorithm_type = each.value.load_balancing_algorithm_type
  name                          = each.key
  port                          = each.value.port
  protocol_version              = "HTTP2"
  protocol                      = each.value.protocol
  target_type                   = each.value.target_type
  vpc_id                        = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  for_each = var.listeners

  alpn_policy       = each.value.alpn_policy
  certificate_arn   = var.ssl_certificate_arn
  load_balancer_arn = module.alb.alb_arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = each.value.ssl_policy

  default_action {
    type = "forward"
  }
}

module "alb_alias" {
  source  = "cloudposse/route53-alias/aws"
  version = "0.13.0"
  # https://registry.terraform.io/modules/cloudposse/route53-alias/aws/0.13.0

  count = var.create_route53_alias ? 1 : 0

  aliases         = [var.alb_route53_alias]
  parent_zone_id  = var.route53_parent_zone_id
  target_dns_name = module.alb.alb_dns_name
  target_zone_id  = module.alb.alb_zone_id
  context         = module.this.context
}
