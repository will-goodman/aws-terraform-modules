
variable "function_name" {
  description = "Name of the lambda function."
}

variable "lambda_handler" {
  description = "Path to the lambda handler in the deployment package e.g. /directory/file.main"
}

variable "memory_size" {
  description = "Memory size to allocate to the lambda in MB."
}

variable "timeout" {
  description = "Timeout period for the lambda in seconds."
}

variable "runtime" {
  description = "Runtime environment for the lambda."
}

variable "logs_retention_period" {
  description = "Length of time to retain the CloudWatch logs of the lambda in days."
}

variable "filename" {
  description = "Path to the zip file containing the deployment package."
}

variable "subnet_ids" {
  description = "Subnets to give the lambda access to."
  type = list(string)
}

variable "security_groups" {
  description = "Security groups to place the lambda in."
  type = list(string)
}
