data "template_file" "kms_policy" {
  template = "${file("./kms_policy.json.tpl")}"
}