variable "tags"{
    description="map of tags to add"
    type=map
}
variable "REGION"{
    default = "us-east-1"
}
variable "vpc_name"{
    default= "default_vpc"
}

variable "public_subnets"{
    type=list
    default=["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]
}

variable "private_subnets"{
    type=list
    default=["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "av_zone"{
    type=list
}

variable "vpc_cidr_block"{
    default= "10.0.0.0/16"
}