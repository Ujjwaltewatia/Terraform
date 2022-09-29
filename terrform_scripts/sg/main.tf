module "my_sg" {
  source = "../../terraform_modules/sg/"
  REGION = var.REGION
  sg_Name = var.sg_Name
  vpc_name = var.vpc_name
  sg_cidr = var.sg_cidr

  tags = {
    Terraform   = "true"
    Environment = "dev"
    created_by  = "UjjwalTewatia"
  }
}

output "aws_ssh_sg" {
    value = [module.my_sg.aws_ssh_sg]
}