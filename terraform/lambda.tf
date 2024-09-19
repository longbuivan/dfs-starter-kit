data "archive_file" "flatting_data" {
  type = "zip"
  source {
    content  = file("../src/flatting_data.py")
    filename = "src/flatting_data.py"
  }

  output_path = "./flatting_data.zip"

}

data "archive_file" "web_ingesting" {
  type = "zip"
  source {
    content  = file("../src/web_ingesting.py")
    filename = "src/web_ingesting.py"
  }

  output_path = "./web_ingesting.zip"

}
# Lambda Raw Data Ingesting

resource "aws_lambda_function" "web_raw_ingesting_lambda" {
  filename         = data.archive_file.web_ingesting.output_path
  function_name    = "web_raw_ingesting_lambda"
  source_code_hash = data.archive_file.web_ingesting.output_base64sha256
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "src/web_ingesting.lambda_handler"
  runtime          = "python3.8"
  timeout          = 60
  memory_size      = 128

  environment {
    variables = {
      WEB_RAW_KINESIS = aws_kinesis_stream.web_raw_streaming.name
      WEB_ENDPOINT    = var.web_data_endpoint
    }
  }
  depends_on = [
    aws_iam_role.lambda_execution_role,
    aws_iam_role_policy_attachment.lambda_iam_policy_basic_execution,
    aws_iam_policy.lambda_execution_policy,
    # aws_lambda_permission.allow_cloudwatch_to_invoke_lambda_permission,
  ]
  tags = local.tags
}


# Lambda Data Flatting
resource "aws_lambda_function" "flatting_data_lambda" {
  function_name    = "flatting_data_lambda"
  filename         = data.archive_file.flatting_data.output_path
  runtime          = "python3.8"
  handler          = "src/flatting_data.lambda_handler"
  timeout          = 60
  memory_size      = 128
  source_code_hash = data.archive_file.flatting_data.output_base64sha256
  role             = aws_iam_role.lambda_execution_role.arn
  depends_on = [
    aws_iam_role.lambda_execution_role,
    aws_iam_role_policy_attachment.lambda_iam_policy_basic_execution,
    aws_iam_policy.lambda_execution_policy,
    # aws_lambda_permission.allow_cloudwatch_to_invoke_lambda_permission,
  ]
  tags = local.tags
}

# resource "aws_lambda_permission" "allow_lambda_access_s3_permission" {
#   statement_id  = "allow_execution_from_s3"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.flatting_data_lambda.arn
#   principal     = "s3.amazonaws.com"
#   source_arn    = aws_s3_bucket.web_raw_data_s3.arn
# }

# resource "aws_s3_bucket_notification" "bucket_terraform_notification" {
#   bucket = aws_s3_bucket.web_raw_data_s3.id
#   lambda_function {
#     lambda_function_arn = aws_lambda_function.flatting_data_lambda.arn
#     events              = ["s3:ObjectCreated:*"]
#   }
# }
