resource "aws_cloudwatch_event_rule" "start_event" {
    name                = "lambda_schedular_rule_start"
    description         = "schedule event stop for lambda"
    schedule_expression = "cron(0 10 * * ? *)"
}

resource "aws_cloudwatch_event_rule" "stop_event" {
    name                = "lambda_schedular_rule_stop"
    description         = "schedule event stop for lambda"
    schedule_expression = "cron(0 23 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_scheduler_target_start" {
    rule =  "${aws_cloudwatch_event_rule.start_event.name}"
    arn  =   "${aws_lambda_function.lambda_function_start.arn}"
}

resource "aws_cloudwatch_event_target" "lambda_scheduler_target_stop" {
    rule =  "${aws_cloudwatch_event_rule.stop_event.name}"
    arn  =   "${aws_lambda_function.lambda_function_stop.arn}"
}
