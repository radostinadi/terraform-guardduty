
variable "aws_account_id" {
    description = "AWS Account ID"
}
variable "aws_region" {
    description = "AWS Region where Guardduty will be enabled"
    default = "eu-west-1"
}
variable "create_sns_topic" {
    description = "Whether to create the SNS topic"
    type        = "string"
    default     = true
}
variable "sns_topic_name" {
    description = "SNS topic where GuardDuty Alerts will be sent"
    type        = "string"
    default     = "GuardDuty_Notifications"
}
variable "sns_delivery_policy" {
    description = "The SNS delivery policy"
    type        = "string"
    default     = "null"
}
variable "guardduty_manage_role" {
    description = "IAM Role which permits enabling GuardDuty"
    default = "GuardDuty_enable_role"
}
variable "bucket_prefix" {
    description = "Prefix for the Guardduty S3 bucket"
    default = "guardduty"
}
variable "guardduty_notification_endpoint" {
    description = "Endpoint for the GuardDuty SNS notifications"
}
variable "guardduty_subscription_protocol" {
    description = "Protocol for the GuardDuty SNS notifications"
}