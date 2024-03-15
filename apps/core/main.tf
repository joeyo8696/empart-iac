locals {
  namespace = "eat"
  stage     = var.stage
  region    = var.region
}

module "network" {
  source = "../../modules/aws/network"

  name        = "network"
  namespace   = local.namespace
  stage       = local.stage
  environment = local.region

  availability_zones      = var.availability_zones
  ipv4_primary_cidr_block = var.vpc_cidr
  subnet_group            = var.subnet_group
}

module "ecs-cluster" {
  source = "../../modules/aws/ecs-cluster"

  name        = "ecs-cluster"
  namespace   = local.namespace
  stage       = local.stage
  environment = local.region
}
