
variable "bucket_name" {
  description = "Name for the S3 bucket. Must be globally unique"
}

variable "bucket_policy" {
  description = "Bucket policy to apply to the bucket"
}

variable "force_destroy" {
  description = "Whether or not to forceably destroy the bucket's contents on a terraform destroy. Default false"
  default = false
}

variable "versioning" {
  description = "Whether or not to enable bucket versioning. Defaults to false"
  default = false
}

variable "region" {
    description = "Region to create the bucket in"
}
