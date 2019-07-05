resource "aws_s3_bucket" "guard_duty" {
  bucket_prefix = "${var.bucket_prefix}"
  region        = "${var.aws_region}"
  acl           = "private"

  lifecycle {
    prevent_destroy = true
  }
}