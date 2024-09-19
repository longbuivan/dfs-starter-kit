resource "aws_kinesis_firehose_delivery_stream" "data_delivery_stream_s3" {
  name        = "web-data-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.web_flatten_data_s3.arn

    buffering_size = 128

    prefix              = "output/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
    error_output_prefix = "error/result=!{firehose:error-output-type}/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"

    data_format_conversion_configuration {
      input_format_configuration {
        deserializer {
          hive_json_ser_de {}
        }
      }

      output_format_configuration {
        serializer {
          parquet_ser_de {}
        }
      }

      schema_configuration {
        database_name = var.glue_resources.database_name
        role_arn      = aws_iam_role.firehose_role.arn
        table_name = var.glue_resources.table_name
      }
    }
  }
}
