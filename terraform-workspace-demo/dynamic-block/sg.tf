resource "aws_security_group" "sg" {
  name        = "dynamic-sg"
  description = "testing dynamic block"
  vpc_id      = "vpc-055b5c9504c2da954"

  dynamic "ingress" {
    for_each = var.inbound_port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dynamic-sg"
  }

}

variable "inbound_port" {
  type        = list(any)
  description = "inbound ports of sg"
  default     = ["80", "443"]
}