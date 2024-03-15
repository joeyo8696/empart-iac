module "empart-dash-ecr" {
  source   = "../../modules/aws/ecr"
  app_name = "empart-dash"
}

module "empart-api-ecr" {
  source   = "../../modules/aws/ecr"
  app_name = "empart-api"
}

module "empart-control-ecr" {
  source   = "../../modules/aws/ecr"
  app_name = "empart-control"
}
