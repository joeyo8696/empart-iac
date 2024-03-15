locals {
  network = {
    availability_zones = ["us-east-1a", "us-east-1b"]
    vpc_cidr           = "172.30.0.0/16"

    subnet_group = {
      core = {
        ipv4_cidr_block        = ["172.30.64.0/18"],
        max_subnet_count       = 1,
        nat_gateway_enabled    = true,
        public_subnets_enabled = true,
      }
    }
  }
}
