
variable "aws_account_id" {}
variable "aws_profile" {}
variable "aws_region" {}

variable "sns_topic" {
  type        = "string"
  description = "SNS topic where GuardDuty Alerts will be sent"
}