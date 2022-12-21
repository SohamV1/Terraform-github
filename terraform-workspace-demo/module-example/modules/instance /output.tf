output "instance_ip_addr" {
  value = aws_instance.my_instance.public_ip
  description = "The Public IP of the instance"
}