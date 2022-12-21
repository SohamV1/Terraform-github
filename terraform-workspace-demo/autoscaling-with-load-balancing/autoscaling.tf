resource "aws_launch_configuration" "my-lc" {
  name            = "my-lc"
  image_id        = "ami-08c40ec9ead489470"
  instance_type   = "t2.micro"
  key_name        = "soham-Devops"
  security_groups = ["${aws_security_group.sg.id}"]
  user_data       = <<EOF
#!/bin/bash
sudo apt update 
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}

resource "aws_autoscaling_group" "ag" {
  name                 = "my-ag"
  max_size             = 3
  min_size             = 1
  health_check_type    = "ELB"
  desired_capacity     = 2
  target_group_arns    = [aws_lb_target_group.test.arn]
  launch_configuration = aws_launch_configuration.my-lc.id
  force_delete         = true
  vpc_zone_identifier  = ["subnet-0ebe3c32191bdad68", "subnet-0d021ab12910e7d6b"]

  tag {
    key                 = "Name"
    value               = "autoscaling-ec2"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "my-asp" {
  name                   = "my-asp"
  autoscaling_group_name = aws_autoscaling_group.ag.name
  policy_type = "TargetTrackingScaling"


  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 20.0
  }
}