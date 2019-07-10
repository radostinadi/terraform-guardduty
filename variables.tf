
variable "aws_account_id" {
    description = "AWS Account ID"
}
variable "aws_region" {
    description = "AWS Region where Guardduty will be enabled"
    default = "eu-west-1"
}
variable "create_sns_topic" {
    description = "Whether SNS topic will be created"
    type        = "string"
    default     = true
}
variable "create_s3_bucket" {
    description = "Whether S3 bucket for Guardduty Logs will be created"
    type        = "string"
    default     = true
}
variable "enable_guardduty_ipset" {
    description = "Whether Guardduty IPSet will be enabled"
    type        = "string"
    default     = true
}
variable "manage_guardduty_role" {
    description = "Whether Policies and Roles Permitting access to GuardDuty and S3 will be created"
    type        = "string"
    default     = true
}
variable "guardduty_assets" {
      default = "guardduty"
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
variable "guardduty_role_name" {
    description = "IAM Role which permits enabling GuardDuty"
    default = "GuardDuty_IAM_Role"
}
variable "guardduty_bucket_prefix" {
    description = "Prefix for the Guardduty S3 bucket"
    default = "guardduty"
}
variable "guardduty_notification_endpoint" {
    description = "Endpoint for the GuardDuty SNS notifications"
}
variable "guardduty_subscription_protocol" {
    description = "Protocol for the GuardDuty SNS notifications"
}