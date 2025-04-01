#!/bin/bash

set -ex  

apt update 
apt install -y nginx
systemctl enable nginx  
systemctl start nginx  
 
apt install   fontconfig openjdk-21-jre -y
apt update 

wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update 
apt-get install jenkins -y
systemctl daemon-reload 
systemctl enable jenkins
systemctl start jenkins 

#INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

cat <<EOT > /etc/nginx/sites-available/jenkins
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }  
}
EOT

ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl restart nginx

#cat /var/lib/jenkins/secrets/initialAdminPassword