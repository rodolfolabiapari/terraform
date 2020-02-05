terraform {
  required_version = ">=0.12"

  # Necessario para quando queremos salvar o estado do tf no s3 por seguranca
  backend "s3" {
    bucket = "linear-dev-terraform-states"
    key    = "linear/dev/erp/eks/mongodb/terraform.tfstate"
    region = "us-east-1"
  }
}
