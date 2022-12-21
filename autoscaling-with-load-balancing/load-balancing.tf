resource "aws_lb" "my-lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = ["subnet-0ebe3c32191bdad68", "subnet-0d021ab12910e7d6b"]

  tags = {
    "Name" = "my-lb"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tg-01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-055b5c9504c2da954"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
