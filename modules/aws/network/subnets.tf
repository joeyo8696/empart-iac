locals {
  private_tags = {
    "Availability" = "private"
  }

  public_tags = {
    "Availability" = "public"
  }
}

module "auto_subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.1"
  # https://registry.terraform.io/modules/cloudposse/dynamic-subnets/aws/2.4.1

  for_each   = var.subnet_group
  tenant     = each.key
  attributes = [each.key]

  availability_zones                    = var.availability_zones
  context                               = module.this.context
  igw_id                                = [module.vpc.igw_id]
  ipv4_cidr_block                       = each.value.ipv4_cidr_block[*]
  ipv4_enabled                          = true
  max_nats                              = var.max_nats
  max_subnet_count                      = each.value.max_subnet_count
  nat_gateway_enabled                   = each.value.nat_gateway_enabled
  private_open_network_acl_enabled      = true
  private_route_table_enabled           = each.value.private_route_table_enabled
  private_subnets_additional_tags       = merge(each.value.additional_private_tags, local.private_tags)
  private_subnets_enabled               = true
  public_open_network_acl_enabled       = true
  public_route_table_enabled            = each.value.public_route_table_enabled
  public_route_table_per_subnet_enabled = false
  public_subnets_additional_tags        = merge(each.value.additional_public_tags, local.public_tags)
  public_subnets_enabled                = each.value.public_subnets_enabled
  vpc_id                                = module.vpc.vpc_id
}
