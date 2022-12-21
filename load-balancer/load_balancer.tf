resource "aws_lb_target_group" "tg-01" {
  name     = "tg-01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-vpc.id
}

resource "aws_lb_target_group_attachment" "tg1" {
  target_group_arn = aws_lb_target_group.tg-01.arn
  target_id        = aws_instance.instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg2" {
  target_group_arn = aws_lb_target_group.tg-01.arn
  target_id        = aws_instance.instance2.id
  port             = 80
}

resource "aws_lb" "lb" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_sg.id}"]
  subnets            = ["${aws_subnet.public-subnet-01.id}", "${aws_subnet.public-subnet-02.id}"]
}

resource "aws_lb_listener" "test-lb-listner" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-01.arn
  }
}

output "lb_public_dns" {
  value = "The dns of lb is ${aws_lb.lb.dns_name}"
}