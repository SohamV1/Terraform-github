provider "aws" {
  region = var.region_name
}

module "my_instance_module" {
  source        = "./modules/instance "
  ami           = "ami-08c40ec9ead489470"
  instance_name = "Terraform_instance"
  instance_type = "t2.micro"
  user_data =<<EOF
#!/bin/bash
sudo apt update
sudo apt install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo "Hello THis is ArYan" > /var/www/html/index.html
EOF
}