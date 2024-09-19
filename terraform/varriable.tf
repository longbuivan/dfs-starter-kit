variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "web_data_endpoint" {
  default = "https://61e67a17ce3a2d0017359174.mockapi.io/web-logs/web"
}

variable "kinesis_lambda_trigger_config" {
  default = {
    config = {
      "batch_size"                         = 5
      "maximum_batching_window_in_seconds" = 30
      "parallelization_factor"             = 1
      "maximum_record_age_in_seconds"      = 60
      "maximum_retry_attempts"             = 0
    }
  }
}


variable "glue_resources" {
  default = {
    database_name = "glue_database"
    table_name    = "glue_flatten_table"
  }
}


# Variable declaration
variable "datalake_bucket_name" {
    type    = string
    default = "dec-datalake"
}

variable "cluster_identifier" {
    type    = string
    default = "dec-cluster"
}

variable "database_name" {
    type    = string
    default = "dec_warehouse"
}

variable "master_username" {
    type    = string
    default = "admin"
}

variable "master_password" {
    type    = string
    default = "password123"
}

variable "node_type" {
    type    = string
    default = "dc2.large"
}

variable "cluster_type" {
    type    = string
    default = "single-node"
}

variable "publicly_accessible" {
    type    = bool
    default = false
}
