#!/bin/bash
sudo su ubuntu
sudo apt-get purge docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

sudo apt-get update
sudo apt-get install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

git clone https://github.com/leticia2983/strapi.git
sudo chown -R ubuntu:ubuntu /home/ubuntu/strapi
sudo chmod -R 755 /home/ubuntu/strapi
cd strapi

sudo  docker compose up -d

sleep 2000

sudo docker-compose restart strapi





#sudo apt update && sudo apt install docker.io docker-compose -y
#sudo systemctl enable docker && sudo usermod -aG docker $USER
#git clone https://github.com/leticia2983/strapi.git
#sudo chown -R ubuntu:ubuntu /home/ubuntu/strapi
#sudo chmod -R 755 /home/ubuntu/strapi
#cd strapi
##sudo docker run -d -p 1337:1337 leticia888444/leticia_strapi:1.0.
#sleep 2000
