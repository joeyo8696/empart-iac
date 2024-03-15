module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.1.1"
  # https://registry.terraform.io/modules/cloudposse/vpc/aws/2.1.1

  assign_generated_ipv6_cidr_block = false
  context                          = module.this.context
  default_network_acl_deny_all     = false
  default_route_table_no_routes    = false
  default_security_group_deny_all  = true
  dns_hostnames_enabled            = true
  dns_support_enabled              = true
  internet_gateway_enabled         = true
  ipv4_primary_cidr_block          = var.ipv4_primary_cidr_block
}
