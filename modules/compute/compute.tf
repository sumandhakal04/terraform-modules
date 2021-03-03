### Public facing instance
resource "aws_instance" "public-instance" {
  ami                         = var.public_ami_name
  instance_type               = var.public_server_instance_type
  subnet_id                   = var.public_subnet_id-1
  key_name                    = var.public_server_key_name
  vpc_security_group_ids      = [var.public_sg]
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "${var.public_instance_name}"
    environment = "${var.environment}"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.public-instance.private_ip} >> private_ips.txt"
  }
}

### Private facing instance
resource "aws_instance" "private-instance" {
  ami                         = var.private_ami_name
  instance_type               = var.private_server_instance_type
  subnet_id                   = var.private_subnet_id-1
  key_name                    = var.private_server_key_name
  vpc_security_group_ids      = [var.private_sg]
  associate_public_ip_address = false
  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "${var.private_instance_name}"
    environment = "${var.environment}"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.private-instance.private_ip} >> private_ips.txt"
  }
}

resource "aws_lb" "web-alb" {
  name               = "Web-ALB-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg]
  subnets            = [var.public_subnet_id-1, var.public_subnet_id-2]
  tags = {
    Name = "Web-ALB-${var.environment}"
    environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "alb-web" {
  name     = "alb-web-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = true
  }
  tags = {
    Name = "alb-web-name-${var.environment}"
    environment = "${var.environment}"
  }
}

resource "aws_lb_listener" "web-alb-listener-http" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-web.arn
  }
}

resource "aws_lb_listener" "web-alb-listener-https" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-web.arn
  }
}

resource "aws_lb_target_group_attachment" "alb-web" {
  target_group_arn = aws_lb_target_group.alb-web.arn
  target_id        = aws_instance.private-instance.id
  port             = 80
}