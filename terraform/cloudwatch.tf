resource "aws_cloudwatch_event_rule" "cron_10_min_lambda_event_rule" {
  name                = "cron_lambda_event_rule"
  description         = "scheduled every 10 min"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "web_ingesting_lambda_target" {
  arn  = aws_lambda_function.web_raw_ingesting_lambda.arn
  rule = aws_cloudwatch_event_rule.cron_10_min_lambda_event_rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_invoke_lambda_permission" {
  statement_id  = "allow_execution_from_cloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.web_raw_ingesting_lambda.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_10_min_lambda_event_rule.arn
}

# resource "aws_cloudwatch_event_target" "redshift_monitoring_target" {
#   arn  = aws_redshiftdata_statement.monitoring_redshift_statement.id
#   rule = aws_cloudwatch_event_rule.cron_10_min_lambda_event_rule.name
# }

