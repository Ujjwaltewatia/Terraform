

provider "aws" {
  region = var.REGION
}

locals{
  igw_name="${var.vpc_name}_IGW"
  publicSubnetName= "${var.vpc_name}_PublicSubnet"
  privateSubnetName= "${var.vpc_name}_PrivateSubnet"
}

resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = merge(var.tags,tomap({"Name"=var.vpc_name}))
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  tags = merge(var.tags,tomap({"Name"=local.igw_name}))
}

 resource "aws_subnet" "publicsubnets" {
   vpc_id = aws_vpc.myvpc.id
   count= length(var.public_subnets)
   cidr_block = element(var.public_subnets,count.index)
   availability_zone = element(var.av_zone,count.index)
   tags = merge(var.tags,tomap({"Name"=format("%s_%d",local.publicSubnetName,count.index)}))
 }

 resource "aws_subnet" "privatesubnets" {
   vpc_id =  aws_vpc.myvpc.id
   count = length(var.private_subnets)
   cidr_block = element(var.private_subnets,count.index)
   availability_zone = element(var.av_zone,count.index)
   tags = merge(var.tags,tomap({"Name"=format("%s_%d",local.privateSubnetName,count.index)}))
 }

 resource "aws_route_table" "PublicRT" { 
    vpc_id =  aws_vpc.myvpc.id
         route {
    cidr_block = "0.0.0.0/0"             
    gateway_id = aws_internet_gateway.igw.id
     }
 }


 resource "aws_route_table" "PrivateRT" { 
   vpc_id = aws_vpc.myvpc.id
   count= length(var.private_subnets)
   route {
   cidr_block = "0.0.0.0/0"
   nat_gateway_id = aws_nat_gateway.natgw[count.index].id
   }
 }

 resource "aws_route_table_association" "PublicRTassociation" {
    count= length(var.public_subnets)
    subnet_id = aws_subnet.publicsubnets[count.index].id
    route_table_id = aws_route_table.PublicRT.id
 }

 resource "aws_route_table_association" "PrivateRTassociation" {
    count = length(var.private_subnets)
    subnet_id = aws_subnet.privatesubnets[count.index].id
    route_table_id = aws_route_table.PrivateRT[count.index].id

 }

 resource "aws_eip" "natIP" {
   count = length(var.private_subnets)
   vpc   = true
 }

  resource "aws_nat_gateway" "natgw" {
   count = length(var.private_subnets)
   #allocation_id = element(aws_eip.natIP.id,count.index)
   allocation_id = aws_eip.natIP[count.index].id
   subnet_id = aws_subnet.publicsubnets[count.index].id
 }