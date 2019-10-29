

module "EtcdSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ETCD-K8S-HML"
  description = "Security group for ETCD-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}

module "ControllerSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "CONTROLLER-K8S-HML"
  description = "Security group for CONTROLLER-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}

module "ElbSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ELB-K8S-HML"
  description = "Security group for ELB-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}

module "WorkerSystemSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "WORKER-SYSTEM-K8S-HML"
  description = "Security group for WORKER-SYSTEM-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}

module "WorkerPool1SecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "WORKER-POOL-K8S-HML"
  description = "Security group for WORKER-POOL-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}

module "AlbAdmSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ALB-ADM-K8S-HML"
  description = "Security group for ALB-ADM-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}

module "AlbServicesSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ALB-SERVICES-K8S-HML"
  description = "Security group for ALB-SERVICES-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}

module "ElasticSearchSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ELASTIC-SEARCH-K8S-HML"
  description = "Security group for ELASTIC-SEARCH-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  tags = local.tags
}


output "AlbAdmSecurityGroup" {
  description = "The ALB ADM SG"
  value       = module.AlbAdmSecurityGroup.this_security_group_id
}

output "AlbServicesSecurityGroup" {
  description = "The ALB Services SG"
  value       = module.AlbServicesSecurityGroup.this_security_group_id
}