
resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  handler = var.lambda_handler
  role = aws_iam_role.iam_for_lambda.arn

  memory_size = var.memory_size
  timeout = var.timeout
  runtime = var.runtime

  filename = var.filename
  source_code_hash = filebase64sha256(var.filename)

  vpc_config {
    security_group_ids = [var.security_groups]
    subnet_ids = [var.subnet_ids]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_${var.function_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.logs_retention_period
}

resource "aws_iam_policy" "lambda_logging" {
  name = "${var.function_name}_lambda_logging"
  path = "/"
  description = "IAM policy for logging lambda ${var.function_name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
