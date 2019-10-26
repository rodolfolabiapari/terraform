# Provide is a provider is a plugin that Terraform uses to translate the API interactions with the service. 
# A provider is responsible for understanding API interactions and exposing resources. 
# Because Terraform can interact with any API, almost any infrastructure type can be represented as a resource in Terraform.



## Variables
variable "region" {
  default = "us-east-1"
} 


variable "cirdrs" {
  default = [ "172.21.0.0/16", "172.21.8.0/21", "172.21.16.0/21", "172.21.24.0/21", "172.21.32.0/21", "172.21.40.0/21" ]
}





provider "aws" {
  profile = "linuxplaceqas"
  region  = var.region        # "us-east-1"
}


# The resource block has two strings before opening the block: the resource type and the resource name.

resource "aws_instance" "bastion" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
