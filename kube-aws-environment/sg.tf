

module "EtcdSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ETCD-K8S-HML"
  description = "Security group for ETCD-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  # https://github.com/coreos/kube-prometheus/blob/master/docs/monitoring-external-etcd.md
  ingress_with_source_security_group_id = [
    {
      from_port   = 2379
      to_port     = 2379
      protocol    = "tcp"
      description = "Prometheus Port for kube-proxy from sg himself"
      source_security_group_id = module.WorkerPool1SecurityGroup.this_security_group_id
    },
    {
      from_port   = 2379
      to_port     = 2379
      protocol    = "tcp"
      description = "Prometheus Port for kube-proxy from sg controller"
      source_security_group_id = module.ControllerSecurityGroup.this_security_group_id
    }
  ]
  
  tags = local.tags
}

module "ControllerSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "CONTROLLER-K8S-HML"
  description = "Security group for CONTROLLER-K8S-HML"
  vpc_id      = module.k8sVpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port   = 10249
      to_port     = 10249
      protocol    = "tcp"
      description = "Prometheus Port for kube-proxy from sg himself"
      source_security_group_id = module.WorkerPool1SecurityGroup.this_security_group_id
    },
    {
      from_port   = 10249
      to_port     = 10249
      protocol    = "tcp"
      description = "Prometheus Port for kube-proxy from sg controller"
      source_security_group_id = module.ControllerSecurityGroup.this_security_group_id
    }
  ]

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

  ingress_with_source_security_group_id = [
    {
      from_port   = 10249
      to_port     = 10249
      protocol    = "tcp"
      description = "Prometheus Port for kube-proxy from sg himself"
      source_security_group_id = module.WorkerPool1SecurityGroup.this_security_group_id
    },
    {
      from_port   = 10249
      to_port     = 10249
      protocol    = "tcp"
      description = "Prometheus Port for kube-proxy from sg controller"
      source_security_group_id = module.ControllerSecurityGroup.this_security_group_id
    }
  ]


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

module "sshSecurityGroup" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Bastion-Kubernetes-SSH"
  description = "Security group for user-service for SSH"
  vpc_id      = "${module.k8sVpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH para conexao no Bastion Kubernetes"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "Internet"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = local.tags
}


output "sg-apiEndpoints" {
  description = "apiEndpoints"
  value       = module.AlbAdmSecurityGroup.this_security_group_id
}

output "sg-controller" {
  description = "controller"
  value       = module.ControllerSecurityGroup.this_security_group_id
}

output "sg-worker" {
  description = "worker"
  value       = module.WorkerPool1SecurityGroup.this_security_group_id
}

output "sg-etcd" {
  description = "etcd"
  value       = module.EtcdSecurityGroup.this_security_group_id
}




#output "AlbAdmSecurityGroup" {
#  description = "The ALB ADM SG"
#  value       = module.AlbAdmSecurityGroup.this_security_group_id
#}
#
#output "AlbServicesSecurityGroup" {
#  description = "The ALB Services SG"
#  value       = module.AlbServicesSecurityGroup.this_security_group_id
#}