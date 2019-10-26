



variable "net-priv-a" {
  default = "Kubernetes-Private-A"
}
variable "net-priv-b" {
  default = "Kubernetes-Private-B"
}
variable "net-priv-c" {
  default = "Kubernetes-Private-C"
}


variable "net-publ-a" {
  default = "Kubernetes-Public-A"
}

variable "net-publ-b" {
  default = "Kubernetes-Public-B"
}

variable "net-publ-c" {
  default = "Kubernetes-Public-C"
}




## Variables
variable "region" {
  default = "us-east-1"
}

provider "aws" {
  profile = "linuxplaceqas"
  region  = var.region     
}




module "vpc" {
  # Module source
  source = "terraform-aws-modules/vpc/aws"

  name = "K8S-Network"
  cidr = "10.21.0.0/16"

  # Enable DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enable NAT Gateway to Private Subnet using single NAT
  enable_nat_gateway   = true
  single_nat_gateway   = true


  azs             = ["eu-east-1a", "eu-east-1b", "eu-east-1c"]
  private_subnets = [ "10.21.0.0/16", "10.21.8.0/21", "10.21.16.0/21" ]

  private_subnet_tags = {
    Name = "K8S-Private"
  } 

  public_subnets  = [ "10.21.24.0/21", "10.21.32.0/21", "10.21.40.0/21" ]
  
  public_subnet_tags  = {
    Name = "K8S-Public"
  }

  # suffix to append to private subnets name
  private_subnet_suffix = "k8s"

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }
}
