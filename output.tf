output lambda_arn {
  value = aws_lambda_function.lambda.arn
}

output lambda_role_name {
  value = aws_iam_role.lambda.name
}
