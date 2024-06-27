resource "aws_security_group" "strapi-sg-let" {
  vpc_id      = aws_vpc.strapi_vpc.id
  description = "Security group for Strapi Application on Docker"
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = "1337"
    to_port     = "1337"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Strapi-SG"
  }

}


resource "aws_instance" "strapi-ec2-let" {
  ami                         = var.ami
  instance_type               = "t2.small"
  vpc_security_group_ids      = [aws_security_group.strapi-sg-let.id]
  subnet_id                   = aws_subnet.public_subnet1.id
  key_name                    = var.keyname
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              set -e  # Exit script on any error
              exec > >(tee /var/log/user_data.log|logger -t user_data -s 2>/dev/console) 2>&1
              sudo apt update && sudo apt install docker.io docker-compose -y
              sudo systemctl enable docker && sudo usermod -aG docker $USER
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
              git clone https://github.com/leticia2983/strapi.git
              cd strapi
              docker-compose up -d
              sleep 10
              EOF

  tags = {
    Name = "Strapi_ec2-let"
  }
}

