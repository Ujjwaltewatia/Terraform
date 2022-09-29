variable "sg_Name" {
    default="ssh_sg"
}

variable "vpc_name" {}

variable "sg_cidr" {
    type = list
}

variable "REGION" {
    default = "us-east-1"
}

variable "tags" {
    type = map
}