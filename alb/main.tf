
resource "aws_lb" "alb" {
  name = var.alb_name

  load_balancer_type = "application"

  security_groups = var.security_groups
  subnets = var.subnets

  access_logs {
    bucket = aws_s3_bucket.alb_access_logs.bucket
    enabled = var.enable_access_logs
  }
}

resource "aws_s3_bucket" "alb_access_logs" {
  bucket_prefix = "${var.alb_name}-access-logs"

  //policy = data.aws_iam_policy_document.alb_logging.json

  force_destroy = true
  lifecycle_rule {
    enabled = true
    expiration {
      days = var.access_logs_retention_period
    }
  }
}

//data "aws_iam_policy_document" "alb_logging" {
//  statement {
//    actions = [
//      "s3:PutObject"
//    ]
//    effect = "Allow"
//    resources = [aws_s3_bucket.alb_access_logs.arn]
//  }
//}
