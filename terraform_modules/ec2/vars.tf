variable "REGION" {
    default = "us-east-1"
}

variable "ami" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "instance_name" {}
variable "tags" {
    type = map
}

variable "vpc_security_group_ids" {
    type=list
}

variable "volume_size" {}
variable "key_name" {}