variable "aws_region" {
  type = string
}

variable "owner_id" {
  type = string  
}

variable "vpc_name" {
  type = string  
}

variable "subnet_name" {
  type = string  
}

variable "sg_name" {
  type = string
}

variable "vol" {
  type = list(object({
    vol_name = string
    vol_type = string
  }))  
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "key_name" {
  type = string
}

variable "inst_name" {
  type = string
}
