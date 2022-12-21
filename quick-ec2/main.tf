resource "aws_instance" "my-instance" {
    ami = ""
    instance_type = "t2.micro"
    key_name = "soham-Devops"
    vpc_security_group_ids = []
    
    tags = {
        Name = "prometheus-node"
    }
}