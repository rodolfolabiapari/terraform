module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "kubernetes-lxp-hml"
  acl    = "private"

  versioning = {
    enabled = false
  }

  tags =  local.tags
}