resource "aws_sns_topic" "flatten_data_dead_letter_queue_sns" {
  name            = "flatten-data-dlq-sns"
  tags            = local.tags
}


resource "aws_sns_topic" "monitoring_updates_topic" {
  name = "monitoring-updates-topic"
}