
variable "aws_account_id" {}
variable "aws_region" {
    default = "eu-west-1"
}

variable "aws_sns_topic" {
  type        = "string"
  description = "SNS topic where GuardDuty Alerts will be sent"
}

variable "bucket_prefix" {
  default = "guardduty"
}

variable "group_name" {
  default = "guardduty-admin"
}

variable "users" {
  type = "list"
}