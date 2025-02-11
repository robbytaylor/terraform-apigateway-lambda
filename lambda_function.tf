data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.module}/dist/lambda.zip"
  source_dir  = "${path.module}/placeholders/${var.lambda_runtime}"
}

resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  lifecycle {
    ignore_changes = ["filename", "last_modified", "source_code_hash"]
  }

  dynamic environment {
    for_each = length(var.environment_variables) > 0 ? [true] : []

    content {
      variables = var.environment_variables
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7
  tags              = var.tags
}
