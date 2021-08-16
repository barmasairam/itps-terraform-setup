resource "aws_security_group" "api" {
  name        = "api"
  description = "Allow ec-2 inbound traffic"
  vpc_id      = aws_vpc.itps.id

  ingress {
    description      = "api from VPC"
    from_port        = 8000
    to_port          = 8000
    protocol         = "tcp"
    security_groups      = ["${aws_security_group.api.id}"]
    
  }

  ingress {
    description      = "ec-2 from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups      = ["${aws_security_group.bastion.id}"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-api-sg"
  }
}



resource "aws_instance" "api" {
  ami           = var.ami
  instance_type = var.type
  subnet_id = aws_subnet.privatesubnet[0].id
  key_name = aws_key_pair.itps-key.id 
  vpc_security_group_ids = ["${aws_security_group.api.id}"]
  #user_data = data.template_file.ec2_user_data.rendered
  
tags = {
    Name = "${var.envname}-api"
  }
}