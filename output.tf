output lambda_arn {
  value = aws_lambda_function.lambda.arn
}

output lambda_role_name {
  value = aws_iam_role.lambda.name
}

output api_url {
  value = var.domain_name != "" ? var.domain_name : aws_api_gateway_stage.stage.invoke_url
}