provider "aws" {
  region = var.region
}

# ✅ Security Group Creation
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

 # Generate a random string for uniqueness
 resource "random_string" "suffix" {
   length  = 6
   special = false
   upper   = false
 }

 # Create an S3 bucket with a random suffix
 resource "aws_s3_bucket" "my_bucket" {
   bucket = "${var.bucket}-${random_string.suffix.result}"
 }
 