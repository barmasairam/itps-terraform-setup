resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.petclinic.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-bastion-sg"
  }
}

#key
resource "aws_key_pair" "itps-key" {
  key_name   = "itps-key"
 public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSI2CRiwqwu4OyYYAaOzOZW3Yjlj4QYGs5prxm693sTG76Fx+D74V82D56EEv1FEMHCUFY9Snuy1cqNY6TH6TEMEwFBBNR0TVUQfNrz0HVCDKG7BlHqSr2k/RRaAyexs22UvSYxiqsdDZ9TqtYd3y8TMHPZ/3TX8WYQSqAceoSZsvE55MzogI9f+xTRfxQSOqTSbZQuIZTBjuh32AjXIFd1meT4ksP+U9/owTmU2ANEAb2iAjb/KAp09gmGlBcxFufClnIXtSr/NDMkbDErq4mdfG/i0vkKNh1Y31wHxRb+FTTyS7yj7JAi4qBdxj5H7LkXnxtx7k+DkaFbEvgSoblEsktNDwqe9L4a2m3nRMWII/3kpkb10WZ0EZgZw6BdJsgzi/84zMvL9H/d9aHecbdXJLjMgNOuAoLNBHzQcLQ2WTGRLDwJFMn+ySuAzrrGNcIT14+oj/Sj/InTCBCe8a2nDQNfMo3pGateCUj4UKX0/vpaTOH/J1zL2/krXU6COs= user@DESKTOP-19F8JD0"
}


resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.type
  subnet_id = aws_subnet.pubsubnet[0].id
  key_name = aws_key_pair.itps-key.id 
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  
tags = {
    Name = "${var.envname}-bastion"
  }
}