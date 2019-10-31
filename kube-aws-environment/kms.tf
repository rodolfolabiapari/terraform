


resource "aws_kms_key" "k8s" {
  description             = "KMS kubernetes hml"
  deletion_window_in_days = 7

  policy = "${data.template_file.kms_policy.rendered}"

  tags = "${merge(
    local.tags,
    map(
      "Name", "kubernetes-hml"
    )
  )}"
}

resource "aws_kms_alias" "alias" {
  name          = "alias/kubernetes-hml"
  target_key_id = "${aws_kms_key.k8s.key_id}"
}


output "kms" {
  description = "kms"
  value       = aws_kms_key.k8s.arn
}
