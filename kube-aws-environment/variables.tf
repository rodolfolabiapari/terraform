variable "region" {
  default = "us-east-1"
}


variable "vpcName" {
  default = "K8S-Network"
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

