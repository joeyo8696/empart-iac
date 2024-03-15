module "container_definition" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "x.61.1"
  # https://registry.terraform.io/modules/cloudposse/ecs-container-definition/aws/0.61.1


  command            = ""
  container_image    = "cloudposse/geodesic"
  container_name     = "geodesic"
  disable_networking = ""
  dns_search_domains = ""
  entrypoint         = ""
  environment        = []
  essential          = ""
  healthcheck        = ""
  hostname           = ""
  interactive        = ""
  links              = ""
  log_configuration  = ""
  map_secrets        = ""
  port_mappings      = ""
  secrets            = ""
  system_controls    = ""
  working_directory  = ""
}
