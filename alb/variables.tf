
variable "alb_name" {
  description = "Name of the ALB."
}

variable "security_groups" {
  description = "Security groups to attach to the ALB."
  type = list(string)
}

variable "subnets" {
  description = "Subnets to connect with the ALB."
  type = list(string)
}

variable "enable_access_logs" {
  description = "Enable/disable access logging of the ALB."
}

variable "access_logs_retention_period" {
  description = "How long to store the access logs in days."
}
