resource "aws_security_group" "front_end" {
  name        = "front_end"
  description = "Allow ec-2 inbound traffic"
  vpc_id      = aws_vpc.itps.id

  ingress {
    description      = "front_end from VPC"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    security_groups      = ["${aws_security_group.front_end.id}"]
    
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
    Name = "${var.envname}-front_end-sg"
  }
}



resource "aws_instance" "front_end" {
  ami           = var.ami
  instance_type = var.type
  subnet_id = aws_subnet.privatesubnet[0].id
  key_name = aws_key_pair.itps-key.id 
  vpc_security_group_ids = ["${aws_security_group.front_end.id}"]
  #user_data = data.template_file.ec2_user_data.rendered
  
tags = {
    Name = "${var.envname}-front_end"
  }
}