
variable "vpc_name" {
  description = "Name to assign to the VPC."
}

variable "vpc_cidr" {
  description = "CIDR range of the VPC."
}

variable "public_cidr_range" {
  description = "CIDR range of the public subnet."
}

variable "second_public_cidr_range" {
  description = "CIDR range of the second public subnet."
}

variable "private_cidr_range" {
  description = "CIDR range of the private subnet."
}

variable "second_private_cidr_range" {
  description = "CIDR range of the second private subnet."
}
