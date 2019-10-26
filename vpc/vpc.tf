



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

variable "azs" {
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

variable "cidrsRegion" {
  default = [
    "10.21.0.0/16"
  ]
}

variable "cidrsSubnet" {
  default = [
    "10.21.8.0/21",
    "10.21.16.0/21",
    "10.21.24.0/21",
    "10.21.32.0/21",
    "10.21.40.0/21",
    "10.21.48.0/21",
    "10.21.56.0/21",
    "10.21.64.0/21",
    "10.21.72.0/21",
    "10.21.80.0/21",
  ]
}






provider "aws" {
  profile = "linuxplaceqas"
  region  = var.region
}


module "vpc" {
  # Module source
  source = "terraform-aws-modules/vpc/aws"

  name = "K8S-Network"
  cidr = var.cidrsRegion[0] #"10.21.0.0/16"

  # Enable DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enable NAT Gateway to Private Subnet using single NAT
  enable_nat_gateway = true
  single_nat_gateway = true


  azs             = var.azs                                    #["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = [var.cidrsSubnet[0], var.cidrsSubnet[1], var.cidrsSubnet[2]] #["10.21.0.0/16", "10.21.8.0/21", "10.21.16.0/21"]
  public_subnets  = [var.cidrsSubnet[3], var.cidrsSubnet[4], var.cidrsSubnet[5]] #["10.21.24.0/21", "10.21.32.0/21", "10.21.40.0/21"]


  # suffix to append to private subnets name
  #private_subnet_suffix = "k8s"

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }
}
