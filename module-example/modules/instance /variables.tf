variable "ami" {
  type = string
  default = "ami-08c40ec9ead489470"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    type = string
    default = "soham-Devops"
}

variable "instance_name" {
    type = string
    default = "my-instance"
}

variable "user_data" {
    type = string
}