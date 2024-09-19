# # resource "aws_glue_catalog_database" "web_database" {
# #     name = "web_database"
# # }

# resource "aws_glue_catalog_table" "glue_flatten_table" {
#   name          = "glue-flatten-table"
#   database_name = "database_athena"
#   table_type    = "EXTERNAL_TABLE"
#   parameters = {
#     EXTERNAL                        = "TRUE"
#     "parquet.compression"           = "SNAPPY"
#     "projection.enabled"            = "true",
#     "projection.year.type"          = "date",
#     "projection.year.range"         = "2021,NOW",
#     "projection.year.format"        = "yyyy",
#     "projection.year.internal.unit" = "YEARS",
#     "projection.month.type"         = "integer",
#     "projection.month.range"        = "1,12",
#     "projection.month.digits"       = "2",
#     "projection.day.type"           = "integer",
#     "projection.day.range"          = "1,31",
#     "projection.day.digits"         = "2",
#     "projection.hour.type"          = "integer",
#     "projection.hour.range"         = "0,23",
#     "projection.hour.digits"        = "2",
#     "storage.location.template"     = "s3://${aws_s3_bucket.web_flatten_data_s3.bucket}/output/data/year=$${year}/month=$${month}/day=$${day}/hour=$${hour}"
#   }
#   storage_descriptor {
#     location      = "${aws_s3_bucket.web_flatten_data_s3.bucket}/"
#     input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
#     output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
#     ser_de_info {
#       name                  = "flatten-stream"
#       serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
#       parameters = {
#         "serialization.format" = 1
#       }
#     }
#     columns {
#       name = "id"
#       type = "int"
#     }
#     columns {
#       name = "first-name"
#       type = "string"
#     }
#     columns {
#       name = "page-name"
#       type = "string"
#     }
#     columns {
#       name = "page-url"
#       type = "string"
#     }
#     columns {
#       name = "timestamp"
#       type = "string"
#     }
#     columns {
#       name = "item-list"
#       type = "string"
#     }
#   }
#   partition_keys {
#     name = "year"
#     type = "int"
#   }
#   partition_keys {
#     name = "month"
#     type = "int"
#   }
#   partition_keys {
#     name = "day"
#     type = "int"
#   }
#   partition_keys {
#     name = "hour"
#     type = "int"
#   }
# }