# Provider 
provider "aws" {
  profile = "linuxplaceqas"
  region  = var.region
}


# Module for VPC
module "k8sVpc" {
  # Module source
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpcName        # "K8S-Network"
  cidr = var.cidrsRegion[0] # This will get "10.21.0.0/16"

  # Enable DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enable NAT Gateway to Private Subnet using single NAT
  enable_nat_gateway = true
  single_nat_gateway = true


  azs = var.azs # This will resolve to ["us-east-1a", "us-east-1b", "us-east-1c"]

  #["10.21.0.0/16", "10.21.8.0/21", "10.21.16.0/21"]
  private_subnets = [var.cidrsSubnet[0], var.cidrsSubnet[1], var.cidrsSubnet[2]]

  #["10.21.24.0/21", "10.21.32.0/21", "10.21.40.0/21"]
  public_subnets = [var.cidrsSubnet[3], var.cidrsSubnet[4], var.cidrsSubnet[5]]

  tags = local.tags
}




# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.k8sVpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.k8sVpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.k8sVpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.k8sVpc.public_subnets
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.k8sVpc.azs
}
