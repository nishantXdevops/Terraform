provider "aws" {
  region = var.region
}

# ✅ Security Group Creation
resource "aws_security_group" "my_sg" {
  name        = "nishant-security-group"
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

# ✅ EC2 Instances Creation
resource "aws_instance" "instances" {
  for_each        = toset(var.instance_names)
  ami            = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  user_data      = var.user_data
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = each.value
  }
}

# ✅ S3 Bucket Creation
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket
  acl    = "private"
}
