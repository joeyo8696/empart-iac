# Required variables
variable "ipv4_primary_cidr_block" {
  type        = string
  description = "The primary IPv4 CIDR block for the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "The availability zones to use for the subnets"
}

# Optional variables
variable "max_nats" {
  type        = number
  description = "The maximum number of NATs to provision per subnet group"
  default     = 1
}

variable "gateway_vpc_endpoints" {
  type        = list(string)
  default     = []
  description = "A list of Gateway VPC Endpoint names to provision into the VPC."
}

variable "interface_vpc_endpoints" {
  type        = list(string)
  default     = []
  description = "A list of Inteface VPC Endpoint names to provision into the VPC."
}

variable "subnet_group" {
  type = map(object({
    additional_private_tags          = optional(map(string))
    additional_public_tags           = optional(map(string))
    ipv4_cidr_block                  = optional(list(string))
    max_subnet_count                 = optional(number)
    nat_gateway_enabled              = optional(bool)
    private_route_table_enabled      = optional(bool)
    private_subnets_additional_tags  = optional(map(string))
    public_route_table_enabled       = optional(bool)
    public_subnets_enabled           = optional(bool)
    public_subnets_additional_tags   = optional(map(string))
    private_open_network_acl_enabled = optional(bool)
    public_open_network_acl_enabled  = optional(bool)
  }))
  description = "The subnet groups to create"
  default     = {}
}
