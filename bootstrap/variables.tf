
variable "state_bucket_name" {
  description = "Globally unique name for the bucket which stores the Terraform state."
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table which stores the state file lock."
}
