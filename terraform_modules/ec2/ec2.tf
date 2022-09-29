provider "aws" {
  region = var.REGION
}

resource "aws_instance" "ec2_create" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  root_block_device {
    volume_size = var.volume_size
  }
  tags = merge(var.tags,tomap({"Name"=var.instance_name}))


}