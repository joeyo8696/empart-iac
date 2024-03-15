locals {
  stage  = "dev"
  region = "ue1"
}

module "network" {
  source = "../../apps/core"

  stage  = local.stage
  region = local.region

  availability_zones = local.network.availability_zones
  subnet_group       = local.network.subnet_group
  vpc_cidr           = local.network.vpc_cidr
}

module "empart" {
  source = "../../apps/empart"
}
