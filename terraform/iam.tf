resource "aws_iam_policy" "lambda_execution_policy" {
  name = "lambda-execution-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:CopyObject",
        "s3:HeadObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.environment}-web-raw-data-s3.id}",
        "arn:aws:s3:::${var.environment}-web-raw-data-s3.id}/*"
      ]
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "firehose:PutRecord",
        "firehose:PutRecordBatch"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}


# resource "aws_iam_policy" "firehose-execution-policy" {
#   name = "firehose-execution-policy"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:ListBucket",
#         "s3:PutObject",
#         "s3:PutObjectAcl",
#         "s3:CopyObject",
#         "s3:HeadObject"
#       ],
#       "Effect": "Allow",
#       "Resource": [
#         "arn:aws:s3:::${var.environment}-web-flatten-data-s3",
#         "arn:aws:s3:::${var.environment}-web-flatten-data-s3/*"
#       ]
#     },
#     {
#       "Action": [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     },
#     {
#       "Action": [
#         "glue:GetDatabase",
#         "glue:GetDatabases",
#         "glue:GetPartition",
#         "glue:GetPartitions",
#         "glue:GetTable",
#         "glue:GetTableVersion",
#         "glue:GetTableVersions",
#         "glue:GetTables"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF

# }

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#Attach Role and Polices
resource "aws_iam_role_policy_attachment" "lambda_iam_policy_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.id
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}


# resource "aws_iam_role" "firehose_role" {
#   name = "firehose-role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "firehose.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }


# resource "aws_iam_role_policy_attachment" "terraform_firehose_iam_policy_basic_execution" {
#   role       = aws_iam_role.firehose_role.id
#   policy_arn = aws_iam_policy.firehose-execution-policy.arn
# }


# # Redshift Resource
# resource "aws_iam_role" "redshift_scheduled_action_role" {
#   name               = "redshift_scheduled_action_role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": [
#           "scheduler.redshift.amazonaws.com"
#         ]
#       },
#       "Effect": "Allow",
#       "Sid": "AssumeRoleForRedShift"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_policy" "redshift_scheduled_action_role_policy" {
#   name   = "redshift_scheduled_action_role_policy"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#       {
#           "Sid": "ModifyCluster",
#           "Effect": "Allow",
#           "Action": [
#               "redshift:PauseCluster",
#               "redshift:ResumeCluster",
#               "redshift:ResizeCluster"
#           ],
#           "Resource": "${aws_redshift_cluster.redshift_cluster_dw.id}"
#       }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "redshift_scheduled_action_role_policy_attachment" {
#   policy_arn = aws_iam_policy.redshift_scheduled_action_role_policy.arn
#   role       = aws_iam_role.redshift_scheduled_action_role.name
# }
