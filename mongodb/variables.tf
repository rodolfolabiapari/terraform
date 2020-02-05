variable "region" {
  default = "us-east-1"
}

variable "nomeMongodb" {
  default = "mongodb"
}

variable "namespace" {
  default = "default"
}


variable "mongodbRootPassword" {
  default = "rootpassword"
}

variable "mongodbUsername" {
  default = "username"
}


variable "mongodbPassword" {
  default = "password"
}

variable "mongodbDatabase" {
  default = "database"
}


variable "useStatefulSet" {
  default = true
}

variable "storageClassName" {
  default = "mongodb"
}

variable "storageClassType" {
  description = "describe your variable"
  default     = "gp2"
}

variable "pvName" {
  description = "describe your variable"
  default     = "mongodb"
}

variable "pvStorage" {
  description = "describe your variable"
  default     = "10Gi"
}

variable "pvcName" {
  description = "describe your variable"
  default     = "mongodb"
}

variable "pvcStorageRequest" {
  description = "describe your variable"
  default     = "10Gi"
}

variable "persistenceEnabled" {
  description = "describe your variable"
  default     = "true"
}
