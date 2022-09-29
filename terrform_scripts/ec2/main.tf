module "create_ec2" {
  source = "../../terraform_modules/ec2/"
  ami = var.ami
  REGION = var.region
  instance_type = var.instance_type
  instance_name = var.instance_name
  subnet_id = var.subnet_id
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  volume_size = var.volume_size
  tags = {
    Terraform   = "true"
    Environment = "dev"
    created_by  = "UjjwalTewatia"
  }

}
