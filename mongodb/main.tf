# -----------
# AWS
# Configurando conexao com a AWS
provider "aws" {
  region = var.region
}
# -----


module "mongodb" {
  source = "../modules/mongodb"
}
