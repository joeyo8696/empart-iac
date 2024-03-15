locals {
  gateway_vpc_endpoints = { for service in var.gateway_vpc_endpoints :
    service => {
      name            = service
      policy          = null
      route_table_ids = module.auto_subnets["core"].private_route_table_ids
    }
  }

  interface_vpc_endpoints = { for service in var.interface_vpc_endpoints :
    service => {
      name                = service
      policy              = null
      private_dns_enabled = true
      security_group_ids  = []
      subnet_ids          = module.auto_subnets["core"].private_subnet_ids
    }
  }
}

module "vpc_endpoints" {
  source  = "cloudposse/vpc/aws//modules/vpc-endpoints"
  version = "2.2.0"
  # https://registry.terraform.io/modules/cloudposse/vpc/aws/latest/submodules/vpc-endpoints

  gateway_vpc_endpoints   = local.gateway_vpc_endpoints
  interface_vpc_endpoints = local.interface_vpc_endpoints
  vpc_id                  = module.vpc.vpc_id
  context                 = module.this.context
}
