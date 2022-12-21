resource "aws_launch_configuration" "my-lc" {
    name = "my-lc"
    image_id = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    key_name = "soham-Devops"
    security_groups = ["${aws_security_group.auto-sg.id}"]
    user_data =<<EOF
#!/bin/bash
sudo apt update 
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}

#define autoscaling group
resource "aws_autoscaling_group" "my-asg" {
    name = "my-asg"
    max_size = 3
    min_size = 1
    health_check_grace_period = 100
    health_check_type = "EC2"
    desired_capacity = 2
    force_delete = true
    launch_configuration = aws_launch_configuration.my-lc.id
    vpc_zone_identifier = ["subnet-0ebe3c32191bdad68","subnet-0d021ab12910e7d6b"]

    tag {
        key = "Name"
        value = "autoscaling-ec2"
        propagate_at_launch = true
    }
}

#define autoscaling configuration policy
resource "aws_autoscaling_policy" "asg-policy"{
    name = "autoscaling-policy"
    autoscaling_group_name = aws_autoscaling_group.my-asg.name
    policy_type = "TargetTrackingScaling"

    target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 20.0
  }

}