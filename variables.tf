
variable "aws_account_id" {}
variable "aws_region" {
    default = "eu-west-1"
}
variable "aws_sns_topic" {
  type        = "string"
  description = "SNS topic where GuardDuty Alerts will be sent"
  default     = "GuardDuty_Notifications"
}
variable "guardduty_manage_role" {
}
variable "bucket_prefix" {
  default = "guardduty"
}
variable "guardduty_notification_endpoint" {
}
variable "guardduty_subscription_protocol" {
}