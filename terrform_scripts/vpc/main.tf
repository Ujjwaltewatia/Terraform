module "my_vpc" {
  source = "../../terraform_modules/vpc/"
  REGION = var.AWS_REGION
  vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
  av_zone = var.av_zone
  private_subnets = var.public_subnets
  public_subnets  = var.public_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
    created_by  = "UjjwalTewatia"
  }
}