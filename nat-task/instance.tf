resource "aws_instance" "public-instance" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "soham-Devops"
  vpc_security_group_ids = [aws_security_group.sg-01.id]
  subnet_id              = aws_subnet.public_subnet_1.id

  tags = {
    "Name" = "Public-instance"
  }

}

resource "aws_instance" "private-instance" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "soham-Devops"
  vpc_security_group_ids = [aws_security_group.sg-01.id]
  subnet_id              = aws_subnet.private_subnet_1.id


  tags = {
    "Name" = "private-instance"
  }

}