resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  handler       = var.lambda_handler
  role          = aws_iam_role.iam_for_lambda.arn

  memory_size = var.memory_size
  timeout     = var.timeout
  runtime     = var.runtime

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)

  vpc_config {
    security_group_ids = var.security_groups
    subnet_ids         = var.subnet_ids
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

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
    effect = "Allow"
  }
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = [
    "*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.function_name}_lambda_policy"
  path        = "/"
  description = "IAM policy for lambda ${var.function_name}"

  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
