#Creating Instance 1 for load balancer
resource "aws_instance" "instance1" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "soham-Devops"
  subnet_id              = aws_subnet.public-subnet-01.id
  vpc_security_group_ids = ["${aws_security_group.lb_sg.id}"]
  user_data              = <<EOF
#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo systemctl enable nginx 
sudo systemctl start nginx
EOF
  tags = {
    Name = "instance-01"
  }
}

#Creating Instance 2 for load balancer
resource "aws_instance" "instance2" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "soham-Devops"
  subnet_id              = aws_subnet.public-subnet-02.id
  vpc_security_group_ids = ["${aws_security_group.lb_sg.id}"]
  user_data              = <<EOF
#!/bin/bash
sudo apt update 
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
EOF
  tags = {
    Name = "instance-02"
  }
}
