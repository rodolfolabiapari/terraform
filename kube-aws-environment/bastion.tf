

resource "aws_instance" "bastion" {
  ami           = "ami-0b69ea66ff7391e80" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.micro"
  availability_zone = var.azs[0]
  key_name          = "KUBE_LXP"
  security_groups   = 
  associate_public_ip_address = true


  provisioner "local-exec" {
    command = <<EOH
cd /tmp
mkdir ~/bin
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
mv kubectl ~/bin/
chmod +x ~/bin/kubectl
echo 'export PATH=~/bin:$PATH' >> .bashrc
curl -LO https://github.com/kubernetes-incubator/kube-aws/releases/download/v0.13.2/kube-aws-linux-amd64.tar.gz
tar -zxvf kube-aws-linux-amd64.tar.gz
mv linux-amd64/kube-aws ~/bin/
EOH
  } 

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
