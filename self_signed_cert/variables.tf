
variable "key_algorithm" {
  description = "Key algorithm to use to generate the private key."
  default = "RSA"
}

variable "common_name" {
  description = "Domain to create the certificate for."
}

variable "validity_hours" {
  description = "How many hours the certificate should remain valid."
}

variable "allowed_uses" {
  description = "List of reasons the certificate can be used. See https://www.terraform.io/docs/providers/tls/r/self_signed_cert.html"
  type = list(string)
}
