
variable "vpc_cidr" {
  description = "CIDR range of the VPC."
}

variable "subnet_availability_zone" {
  description = "Availability zone to connect the subnets to."
}

variable "public_cidr_range" {
  description = "CIDR range of the public subnet."
}

variable "private_cidr_range" {
  description = "CIDR range of the private subnet."
}
