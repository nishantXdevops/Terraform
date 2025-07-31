provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    # user_data = file("userdata.sh")

 tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "my_sg" {
  name        = "test-security-group"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nishant-Security-Group"
  }
}
