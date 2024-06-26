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
  user_data                   = file("user_data.sh")

  tags = {
    Name = "Strapi_ec2-let"
  }
}

