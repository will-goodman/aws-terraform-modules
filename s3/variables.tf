
variable "bucket_prefix" {
  description = "Prefix for the S3 Bucket name"
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
