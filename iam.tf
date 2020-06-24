resource "aws_iam_role" "lambda_exec_role" {
  name        = "lambda_exec_role"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_policy" "ec2_police" {
  name        = "ec2_police"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."

  policy = <<EOF
{
 "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Start*",
        "ec2:Stop*",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:StartInstances",
        "ec2:StopInstances"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
  
resource "aws_iam_policy" "log_police" {
  name        = "log_police"
  path        = "/"
  description = "Allows Lambda Function to call AWS services on your behalf."

  policy = <<EOF
{
 "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.lambda_exec_role.name}"
  policy_arn = "${aws_iam_policy.ec2_police.arn}"
}

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = "${aws_iam_role.lambda_exec_role.name}"
  policy_arn = "${aws_iam_policy.log_police.arn}"
}

# START
resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_start" {
   statement_id = "allow_cloudwatch_to_call_lambda_start"
   action = "lambda:InvokeFunction"
   function_name = "${aws_lambda_function.lambda_function_start.function_name}"
   principal = "events.amazonaws.com"
   source_arn = "${aws_cloudwatch_event_rule.start_event.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_stop" {
   statement_id = "allow_cloudwatch_to_call_lambda_stop"
   action = "lambda:InvokeFunction"
   function_name = "${aws_lambda_function.lambda_function_stop.function_name}"
   principal = "events.amazonaws.com"
   source_arn = "${aws_cloudwatch_event_rule.stop_event.arn}"
}
