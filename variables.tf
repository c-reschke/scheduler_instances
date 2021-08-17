variable "project_name"{
    default = "scheduler-instance"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "handler" {
  default = "lambda_handler"
}

variable "runtime" {
  default = "python3.7"
}