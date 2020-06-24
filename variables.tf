variable "project_name"{
    default = "scheduler-instance"
}

# AWS Config
variable "aws_access_key" {
  default = "AKIAVXU7XO5YPCANUEP6"
}

variable "aws_secret_key" {
  default = "HxS56SsqG1LNVySa0WM7CftTv/acufGo1LYP/wGl"
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