resource "aws_s3_bucket" "web_flatten_data_s3" {
  force_destroy = true
  bucket        = "${var.environment}-web-flatten-data-s3"
  tags          = local.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "web_raw_data_s3" {
  force_destroy = true
  bucket        = "${var.environment}-web-raw-data-s3"
  tags          = local.tags

  lifecycle {
    prevent_destroy = true
  }
}
