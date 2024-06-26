#!/bin/bash
sudo apt update && sudo apt install docker.io docker-compose -y
sudo systemctl enable docker && sudo usermod -aG docker $USER
git clone https://github.com/leticia2983/strapi.git
sudo chown -R ubuntu:ubuntu /home/ubuntu/strapi
sudo chmod -R 755 /home/ubuntu/strapi
cd strapi
#sudo docker run -d -p 1337:1337 leticia888444/leticia_strapi:1.0.
sleep 2000
