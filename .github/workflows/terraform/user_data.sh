#!/bin/bash


sudo -u ubuntu

# Update and install Docker and Docker Compose
sudo apt update && sudo apt install docker.io docker-compose -y

# Enable Docker to start on boot and add current user to docker group
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Clone Strapi repository into ubuntu user's home directory
sudo git clone https://github.com/leticia2983/strapi.git /home/ubuntu/strapi

# Change ownership and permissions of strapi directory
sudo chown -R ubuntu:ubuntu /home/ubuntu/strapi
sudo chmod -R 755 /home/ubuntu/strapi
cd /home/ubuntu/strapi  # Move into the strapi directory

# Create .env file for Strapi environment variables
cat <<EOT > .env
HOST=mysql
PORT=1337
APP_KEYS=juBiRyxZeo0bOrsaZmM/7g==,9R4d2+jiutM9CmBzx+NGCw==,1XAOCxs2GOWM/vn+Ov72mQ==,jL8tyWbMmqTJ6aAcRIR+PA==
API_TOKEN_SALT=vcz1aqBIwV62viRza/9AiQ==
ADMIN_JWT_SECRET=dZ4G47Sx2ml+YKvtiC5GHw==
TRANSFER_TOKEN_SALT=hYPzxzEYk5kZKppLStl4nA==
DATABASE_CLIENT=mysql
DATABASE_FILENAME=.tmp/data.db
JWT_SECRET=bby5g2LB/5NJKopXw9P5Gw==

DATABASE_CLIENT=mysql
DATABASE_HOST=mysql
DATABASE_PORT=3306
DATABASE_NAME=strapi
DATABASE_USERNAME=root
DATABASE_PASSWORD=password
EOT

# Start Docker containers defined in docker-compose.yml
sudo -u ubuntu docker-compose up -d
