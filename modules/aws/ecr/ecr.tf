module "ecr" {
  source  = "cloudposse/ecr/aws"
  version = "0.40.1"
  # https://registry.terraform.io/modules/cloudposse/ecr/aws/0.40.1

  enable_lifecycle_policy = true
  encryption_configuration = ({
    encryption_type = "KMS"
    kms_key         = null
  })
  image_tag_mutability = var.image_tag_mutability
  max_image_count      = var.max_image_count
  name                 = var.app_name
  protected_tags       = var.protected_tags
  scan_images_on_push  = true
  use_fullname         = false

  context = module.this.context
}
