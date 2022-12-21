output "instance_public_ip" {
  value       = module.my_instance_module.instance_ip_addr
  description = "instance public ip addr"

}