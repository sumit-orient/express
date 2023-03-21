resource "aws_alb_target_group" "pearl-target-group" {
  name     = "pearl-alb-target"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.pearl-vpc.id
#   vpc_id   = "${var.vpc_id}"
  depends_on = [
    aws_vpc.pearl-vpc
  ]

  tags = {
    Name = "pearl-alb-target"
  }
}

resource "aws_lb_target_group_attachment" "pearl-alb-target-group-attachment" {
  target_group_arn = "${aws_alb_target_group.pearl-target-group.arn}"
  target_id        = aws_instance.ubuntu.id
  port             = 3000

  depends_on = [
    aws_instance.ubuntu
  ]
}

resource "aws_alb" "pearl-aws-alb" {
  name            = var.alb_name
  security_groups = ["${aws_security_group.allow_word.id}"]
  subnets         = ["${aws_subnet.pearl-pub-1a.id}","${aws_subnet.pearl-pub-1b.id}"] 
#   subnets         = ["subnet-0abe0962e4961f9aa","subnet-01d268ef341a3343d"]                                            # ["${aws_subnet.main.*.id}"]
  ip_address_type    = "ipv4"
  load_balancer_type = "application"

  depends_on = [
    aws_security_group.allow_word,aws_vpc.pearl-vpc
  ]

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_listener" "pearl-test-alb-listner" {
  load_balancer_arn = "${aws_alb.pearl-aws-alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.pearl-target-group.arn}"
  }

  depends_on = [
    aws_alb.pearl-aws-alb,aws_alb_target_group.pearl-target-group
  ]
}