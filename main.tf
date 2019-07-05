## Enable GuardDuty
provider "aws" {
  region = "${var.aws_region}"
}
resource "aws_guardduty_detector" "guardduty" {
  enable = true
}