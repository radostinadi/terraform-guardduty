data "aws_sns_topic" "guardduty" {
  name = "${var.sns_topic}"
}