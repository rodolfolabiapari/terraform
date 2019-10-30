


resource "aws_kms_key" "k8s" {
  description             = "KMS for S3 Bucket"
  deletion_window_in_days = 7

  policy = "${data.template_file.kms_policy.rendered}"

  tags = local.tags
}

output "kms" {
  description = "kms"
  value       = aws_kms_key.k8s.arn
}
