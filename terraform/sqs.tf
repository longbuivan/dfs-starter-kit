resource "aws_sqs_queue" "raw_data_buffer_sqs" {
  name                       = "raw-data-buffer-sqs"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 86400
  visibility_timeout_seconds = 200

}
resource "aws_sqs_queue_policy" "raw_data_buffer_sqs_policy" {
  queue_url = aws_sqs_queue.raw_data_buffer_sqs.id
  policy    = <<POLICY
{
    "Version": "2012-10-17",
    "Statement":
    [
        {
            "Sid": "raw-data-buffer",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "sqs:SendMessage",
            "Resource": "${aws_sqs_queue.raw_data_buffer_sqs.arn}",
            "Condition": {
                "ArnEquals": {
                    "aws:SourceArn": "${aws_s3_bucket.web_raw_data_s3.arn}"
                }
            }
        }
    ]
}
POLICY
}
