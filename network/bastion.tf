

resource "aws_instance" "bastion" {
  ami           = "ami-0b69ea66ff7391e80" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.micro"
  availability_zone = var.azs[0]
  key_name          = "KUBE_KEY"
  security_groups   = 
  associate_public_ip_address = true

  root_block_device = { 
    volume_type = gp2
    volume_size = 20
  } 

  volume_tags = var.generalTags

  tags = {
    var.generalTags,
    Name = "Kubernetes-Bastion"
  }
}
