## -----------
## AWS
## Configurando conexao com a AWS
#provider "aws" {
#  region = var.region
#}
## -----


# -----
# Kubernetes
# Configurando o Storage Class 
#resource "kubernetes_storage_class" "this" {
#  metadata {
#    name = var.storageClassName
#  }
#  storage_provisioner = "kubernetes.io/aws-ebs"
#  reclaim_policy      = "Retain"
#  parameters = {
#    type = "gp2"
#  }
#}
#
#
#resource "kubernetes_persistent_volume" "this" {
#  metadata {
#    name = var.pvName
#  }
#  spec {
#    capacity = {
#      storage = var.pvStorage
#    }
#    access_modes     = ["ReadWriteMany"]
#    storageClassName = var.storageClassName
#  }
#}
#
#resource "kubernetes_persistent_volume_claim" "this" {
#  metadata {
#    name = var.pvcName
#  }
#  spec {
#    access_modes = ["ReadWriteMany"]
#    resources {
#      requests = {
#        storage = var.pvcStorageRequest
#      }
#    }
#    volume_name = "${kubernetes_persistent_volume.this.metadata.0.name}"
#  }
#}
# -----


# -----
# HELM MongoDB
## TALVEZ Necessita de um PV e PVC antes de sua criacao
provider "helm" {
  version        = "~> 0.9"
  install_tiller = true

  #kubernetes {
  # Will try first $HOME/.kube/config
  # config_path = "/path/to/kube_cluster.yaml"
  #}
}

resource "helm_release" "mongodb" {
  name      = var.namemongo
  chart     = "${path.module}/consul-helm"
  namespace = var.namespace

  set {
    name  = "mongodbRootPassword"
    value = var.mongodbRootPassword
  }

  set {
    name  = "mongodbUsername"
    value = var.mongodbUsername
  }

  set {
    name  = "mongodbPassword"
    value = var.mongodbPassword
  }

  set {
    name  = "mongodbDatabase"
    value = var.mongodbPassword
  }

  set {
    name  = "useStatefulSet"
    value = var.useStatefulSet
  }

  set {
    name  = "persistence.enabled"
    value = var.persistenceEnabled
  }

  #set {
  #  name  = "persistence.existingClaim"
  #  value = var.pvcName
  #}

  set {
    name  = "persistence.storageClass"
    value = var.storageClassType
  }

  set {
    name  = "persistence.storageClassName"
    value = var.storageClassName
  }

}
# -----
