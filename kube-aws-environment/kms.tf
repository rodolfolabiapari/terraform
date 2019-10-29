


resource "aws_kms_key" "k8s" {
  description             = "KMS for S3 Bucket"
  deletion_window_in_days = 7

  tags = local.tags
}
