
resource "aws_sns_topic" "guardduty_sns_topic" {
  count   = "${var.create_sns_topic ? 1 : 0}"
  name    = "${var.sns_topic_name}"
  delivery_policy = "${var.sns_delivery_policy}"
}

resource "aws_sns_topic_subscription" "guardguty_notifications" {
  topic_arn = "${aws_sns_topic.guardduty_sns_topic.arn}"
  protocol  = "${var.guardduty_subscription_protocol}"
  endpoint  = "${var.guardduty_notification_endpoint}"
}