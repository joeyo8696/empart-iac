variable "app_name" {
  description = "the name of the application the resource will be part of"
  type        = string
}

variable "image_tag_mutability" {
  description = "configures image mutability for the ECR repository"
  type        = string
  default     = "IMMUTABLE"
}

variable "max_image_count" {
  description = "the maximum number of images to keep in the repository"
  type        = number
  default     = 50
}

variable "protected_tags" {
  description = "list of image tag prefixes that are protected"
  type        = list(string)
  default     = ["latest"]
}
