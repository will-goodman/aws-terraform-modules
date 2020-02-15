
resource "tls_private_key" "example" {
  algorithm = var.key_algorithm
}

resource "tls_self_signed_cert" "example" {
  key_algorithm   = var.key_algorithm
  private_key_pem = tls_private_key.example.private_key_pem

  subject {
    common_name  = var.common_name
  }

  validity_period_hours = var.validity_hours

  allowed_uses = var.allowed_uses
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.example.private_key_pem
  certificate_body = tls_self_signed_cert.example.cert_pem
}
