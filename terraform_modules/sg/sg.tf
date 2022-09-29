provider "aws" {
  region = var.REGION
}
data "aws_vpc" "vpc_id" {
  filter {
    name = "Name"
    values = [var.vpc_name]
  }
}

resource "aws_security_group" "aws_ssh_sg" {
  name        = var.sg_Name
  description = "Allow SSH access inbound traffic"
  vpc_id      = data.aws_vpc.vpc_id.id

  ingress {
    description      = "SSH access from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.sg_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags,tomap({"Name"=var.sg_Name}))
}