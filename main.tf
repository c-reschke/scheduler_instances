# START

data "archive_file" "lambda_archive_start" {
  type        = "zip"
  source_file = "lambda_function_start.py"
  output_path = "lambda_function_start.zip"

}

resource "aws_lambda_function" "lambda_function_start" {
  
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "lambda_function_start.${var.handler}"
  runtime          = "${var.runtime}"
  filename         = "lambda_function_start.zip"
  function_name    = "lambda_function_start"
  source_code_hash = "${data.archive_file.lambda_archive_start.output_base64sha256}"
  timeout          = 30
  memory_size      = 128
  
  depends_on = [
    "aws_iam_role_policy_attachment.lambda_logs",
    "aws_iam_role_policy_attachment.ec2", 
    "aws_cloudwatch_log_group.start_instances",
    "aws_cloudwatch_log_group.stop_instances"
    ]
}

# STOP

data "archive_file" "lambda_archive_stop" {
  type        = "zip"
  source_file = "lambda_function_stop.py"
  output_path = "lambda_function_stop.zip"

}


resource "aws_lambda_function" "lambda_function_stop" {
  
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "lambda_function_stop.${var.handler}"
  runtime          = "${var.runtime}"
  filename         = "lambda_function_stop.zip"
  function_name    = "lambda_function_stop"
  source_code_hash = "${data.archive_file.lambda_archive_stop.output_base64sha256}"
  timeout          = 30
  memory_size      = 128
  
  depends_on = ["aws_iam_role_policy_attachment.lambda_logs", "aws_iam_role_policy_attachment.ec2"]
}


