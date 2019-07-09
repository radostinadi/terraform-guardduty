
resource "aws_sns_topic" "guardduty_sns_topic" {
  name = "${var.aws_sns_topic}"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
      "disableSubscriptionOverrides": false,
      "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

resource "aws_sns_topic_subscription" "guardguty_notifications" {
  topic_arn = "${aws_sns_topic.guardduty_sns_topic.arn}"
  protocol  = "${var.guardduty_subscription_protocol}"
  endpoint  = "${var.guardduty_notification_endpoint}"
}