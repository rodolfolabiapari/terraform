
resource "aws_instance" "bastion" {
  ami                         = "ami-01ff8aa58269fddd1" # Amazon Linux 2 AMI (HVM)
  instance_type               = "t2.micro"
  availability_zone           = var.azs[0]
  key_name                    = "KUBE-LXP"
  vpc_security_group_ids      = ["${module.sshSecurityGroup.this_security_group_id}"]
  subnet_id                   = "${module.k8sVpc.public_subnets[0]}"
  associate_public_ip_address = true


  #  provisioner "local-exec" {
  #    command = <<EOH
  #cd /tmp
  #mkdir ~/bin
  #curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  #mv kubectl ~/bin/
  #chmod +x ~/bin/kubectl
  #echo 'export PATH=~/bin:$PATH' >> .bashrc
  #curl -LO https://github.com/kubernetes-incubator/kube-aws/releases/download/v0.13.2/kube-aws-linux-amd64.tar.gz
  #tar -zxvf kube-aws-linux-amd64.tar.gz
  #mv linux-amd64/kube-aws ~/bin/
  #EOH
  #  } 

  #  root_block_device = { 
  #    volume_type = gp2
  #    volume_size = 20
  #  } 

  volume_tags = local.tags

  tags = "${merge(
    local.tags,
    map(
      "Name", "Bastion Kubernetes"
    )
  )}"
}




#resource "aws_volume_attachment" "attach" {
#
#  device_name = "/dev/xvda"
#  volume_id   = "vol-0e87e68c2c81fe625"
#  instance_id = aws_instance.bastion.id
#}