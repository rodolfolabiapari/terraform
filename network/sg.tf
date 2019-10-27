

module "EtcdSecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ETCD-K8S-HML"
  description = "Security group for ETCD-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}

module "ControllerSecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "CONTROLLER-K8S-HML"
  description = "Security group for CONTROLLER-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}

module "ElbSecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ELB-K8S-HML"
  description = "Security group for ELB-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}

module "WorkerSystemSecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "WORKER-SYSTEM-K8S-HML"
  description = "Security group for WORKER-SYSTEM-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}

module "WorkerPool1SecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "WORKER-POOL-K8S-HML"
  description = "Security group for WORKER-POOL-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}

module "AlbAdmSecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ALB-ADM-K8S-HML"
  description = "Security group for ALB-ADM-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}

module "AlbServicesSecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ALB-SERVICES-K8S-HML"
  description = "Security group for ALB-SERVICES-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}

module "ElasticSearchSecurityGroupName" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ELASTIC-SEARCH-K8S-HML"
  description = "Security group for ELASTIC-SEARCH-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = {
    Owner       = "Rodolfo"
    Build       = "TerraForm"
    Environment = "HML"
  }

}
