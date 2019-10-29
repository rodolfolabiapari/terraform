# fazer um nlb


resource "aws_lb" "K8sNlb" {
  name               = "MICROSSERVICOS-NLB-K8S-HML"
  internal           = true
  load_balancer_type = "network"
  #security_groups    =  # There is no SG in Layer 4
  subnets = module.k8sVpc.private_subnets

  # If true, cross-zone load balancing of the load balancer will be enabled.
  enable_cross_zone_load_balancing = true

  #enable_deletion_protection = true

  tags = local.tags
}

resource "aws_lb_target_group" "K8sNlbTargetGroup" {
  name     = "MICROSSERVICOS-TG-NLB-K8S-HML"
  port     = 30745
  protocol = "TCP"
  vpc_id   = "${module.k8sVpc.vpc_id}"

  health_check {
    interval            = 30
    protocol            = "TCP"
    #timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "K8sNlbListener" {
  load_balancer_arn = "${aws_lb.K8sNlb.arn}"
  port              = "30745"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.K8sNlbTargetGroup.arn}"
  }
}




resource "aws_lb" "K8sAlbAdm" {
  name               = "ADMIN-K8S-HML"
  internal           = true
  load_balancer_type = "application"
  #security_groups    = module.AlbAdmSecurityGroup.this_security_group_id
  subnets = module.k8sVpc.private_subnets

  #enable_deletion_protection = true

  tags = local.tags
}

resource "aws_lb_target_group" "K8sAlbAdmTargetGroup" {
  name     = "ADMIN-K8S-HML"
  port     = 30744
  protocol = "HTTP"
  vpc_id   = "${module.k8sVpc.vpc_id}"

  health_check {
    interval            = 30
    protocol            = "HTTP"
    port                = 30744
    path                = "/healthz"
    timeout             = 10
    matcher             = 200
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "K8sAlbAdmListener" {
  load_balancer_arn = "${aws_lb.K8sAlbAdm.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.K8sAlbAdmTargetGroup.arn}"
  }
}



resource "aws_lb" "K8sAlbServices" {
  name               = "MICROSSERVICOS-ALB-K8S-HML"
  internal           = true
  load_balancer_type = "application"
  #security_groups    = module.AlbServicesSecurityGroup.this_security_group_id
  subnets = module.k8sVpc.private_subnets

  #enable_deletion_protection = true

  tags = local.tags
}

resource "aws_lb_target_group" "K8sAlbServicesTargetGroup" {
  name     = "MICROSSERVICOS-TG-ALB-K8S-HML"
  port     = 30745
  protocol = "HTTP"
  vpc_id   = "${module.k8sVpc.vpc_id}"

  health_check {
    interval            = 30
    protocol            = "HTTP"
    port                = 30745
    path                = "/healthz"
    timeout             = 10
    matcher             = 200
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "K8sAlbServicesListener" {
  load_balancer_arn = "${aws_lb.K8sAlbServices.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.K8sAlbServicesTargetGroup.arn}"
  }
}


