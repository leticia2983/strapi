#!/bin/bash


sudo apt update && sudo apt install docker.io docker-compose -y
sudo systemctl enable docker && sudo usermod -aG docker $USER


git clone https://github.com/leticia2983/strapi.git
sudo chown -R ubuntu:ubuntu /home/ubuntu/strapi
sudo chmod -R 755 /home/ubuntu/strapi
cd strapi

cat <<EOT > .env
HOST=mysql
PORT=1337
APP_KEYS=juBiRyxZeo0bOrsaZmM/7g==,9R4d2+jiutM9CmBzx+NGCw==,1XAOCxs2GOWM/vn+Ov72mQ==,jL8tyWbMmqTJ6aAcRIR+PA==
API_TOKEN_SALT=vcz1aqBIwV62viRza/9AiQ==
ADMIN_JWT_SECRET=dZ4G47Sx2ml+YKvtiC5GHw==
TRANSFER_TOKEN_SALT=hYPzxzEYk5kZKppLStl4nA==
Database
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


sudo docker-compose up -d










