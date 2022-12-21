locals {
  instance_name = "${terraform.workspace}-instance"
}

resource "aws_instance" "ec2-instance" {
    ami = "ami-08c40ec9ead489470"
    instance_type = var.instance_type
    key_name = "soham-Devops"

    tags = {
        "Name" = local.instance_name
    }
}