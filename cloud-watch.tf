resource "aws_cloudwatch_log_group" "start_instances" {
  name              = "/aws/lambda/lambda_function_start"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "stop_instances" {
  name              = "/aws/lambda/lambda_function_stop"
  retention_in_days = 1
}