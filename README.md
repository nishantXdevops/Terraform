provider "aws" {
  region = "us-east-1"
}

# ✅ Create Security Group separately
resource "aws_security_group" "my_sg" {
  name        = "nishant-security-group"
  description = "Allow SSH (22) and HTTP (80) inbound, all outbound"

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  # Outbound Rules (Allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nishant-Security-Group"
  }
}

# ✅ Create EC2 Instance
resource "aws_instance" "Nishant_sharma" {
  ami           = "ami-0129865974a10c1cb" 
  instance_type = "t3.micro"
  key_name      = "test" 

  vpc_security_group_ids = [aws_security_group.my_sg.id] # Attach the security group

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install samba -y

              # Create a Samba share directory
              mkdir -p /srv/samba/shared
              chmod 777 /srv/samba/shared

              # Create Samba user and set password
              useradd -m nishant
              echo -e "q\nq" | smbpasswd -a -s nishant

              # Configure Samba
              echo "[Shared]" >> /etc/samba/smb.conf
              echo "   path = /srv/samba/shared" >> /etc/samba/smb.conf
              echo "   browseable = yes" >> /etc/samba/smb.conf
              echo "   read only = no" >> /etc/samba/smb.conf
              echo "   guest ok = no" >> /etc/samba/smb.conf
              echo "   valid users = nishant" >> /etc/samba/smb.conf

              # Restart Samba service
              systemctl restart smbd
              systemctl enable smbd

              # Show Samba password in logs (optional, not secure for production)
              echo "Samba Username: nishant"
              echo "Samba Password: q"
              EOF

  tags = {
    Name = "Nishant_sharma"
  }
}

# ✅ Create S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-nishant" # Use a globally unique name
  acl    = "private"
}


![alt text](image.png)