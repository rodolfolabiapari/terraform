module "EtcdPolicyName" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 2.0"

  name        = "ETCD-K8S-HML"
  path        = "/"
  description = "Policy for ETCD-K8S-HML"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:DescribeTags"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowDescribeTags"
        },
        {
            "Action": [
                "cloudwatch:GetMetricData",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:PutMetricData"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowCloudwatchMetrics"
        },
        {
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchGetImage",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowEcr"
        },
        {
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": [
                "${aws_kms_key.k8s.arn}"
            ],
            "Effect": "Allow",
            "Sid": "AllowKmsDecryptK8SS3"
        },
        {
            "Action": [
                "ssm:GetParameters",
                "ssm:DescribeParameters"
            ],
            "Resource": [
                "arn:aws:ssm:us-east-1:00000:parameter/NEWRELIC/LICENSE"
            ],
            "Effect": "Allow",
            "Sid": "AllowSSMNewRelic"
        }
    ]
}
EOF
}

module "ControllerPolicyName" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 2.0"

  name        = "CONTROLLER-K8S-HML"
  path        = "/"
  description = "Policy for CONTROLLER-K8S-HML"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowDescribeEc2"
        },
        {
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": [
                "${aws_kms_key.k8s.arn}"
            ],
            "Effect": "Allow",
            "Sid": "AllowKmsDecryptK8SS3"
        }
    ]
}
EOF
}

module "WorkerComumPolicyName" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 2.0"

  name        = "WORKER-COMMON-K8S-HML"
  path        = "/"
  description = "Policy for WORKER-COMMON-K8S-HML"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "cloudwatch:PutMetricData",
                "cloudwatch:PutMetricAlarm",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:ListMetrics",
                "cloudwatch:DescribeAlarms"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowCloudwatchMetrics"
        },
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowCloudwatchLogs"
        },
        {
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": [
                "${aws_kms_key.k8s.arn}"
            ],
            "Effect": "Allow",
            "Sid": "AllowKinesis"
        }
    ]
}
EOF
}

module "WorkerSystemPolicyName" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 2.0"

  name        = "WORKER-SYSTEM-K8S-HML"
  path        = "/"
  description = "Policy for WORKER-SYSTEM-K8S-HML"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:Describe*",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowASGAccess"
        }
    ]
}
EOF
}

module "WorkerPool1PolicyName" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 2.0"

  name        = "WORKER-POOL-K8S-HML"
  path        = "/"
  description = "Policy for WORKER-POOL-K8S-HML"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchGetItem"
            ],
            "Resource": [
                "arn:aws:dynamodb:us-east-1:00000:table/HML*'",
                "arn:aws:dynamodb:us-east-1:00000:table/HML*'"
            ],
            "Effect": "Allow",
            "Sid": "AllowDynamoDB"
        },
        {
            "Action": [
                "sqs:ListQueues",
                "sqs:DeleteMessage",
                "sqs:GetQueueUrl",
                "sqs:ChangeMessageVisibility",
                "sqs:SendMessageBatch",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:ChangeMessageVisibilityBatch"
            ],
            "Resource": [
                "arn:aws:sqs:us-east-1:000000:HML*'",
                "arn:aws:sqs:us-east-1:000000:HML*'"
            ],
            "Effect": "Allow",
            "Sid": "AllowSQS"
        },
        {
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::bkt-HML-consorcio",
                "arn:aws:s3:::bkt-HML-consorcio/*",
                "arn:aws:s3:::bkt-HML-sandbox",
                "arn:aws:s3:::bkt-HML-sandbox"
            ],
            "Effect": "Allow",
            "Sid": "AllowS3"
        },
        {
            "Action": [
                "ssm:DescribeParameters",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": [
                "arn:aws:ssm:us-east-1:000000:parameter/HML*'",
                "arn:aws:ssm:us-east-1:000000:parameter/HML*'"
            ],
            "Effect": "Allow",
            "Sid": "AllowSSM"
        },
        {
            "Action": [
                "ses:SendEmail",
                "ses:SendRawEmail"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowSES"
        },
        {
            "Action": [
                "sns:Publish",
                "sns:SetSMSAttributes"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowSNS"
        },
        {
            "Action": [
                "rekognition:*"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow",
            "Sid": "AllowRekognition"
        }
    ]
}
EOF
}


output "iam-EtcdPolicyName" {
  description = "EtcdPolicyName"
  value       = module.EtcdPolicyName.arn
}

output "iam-ControllerPolicyName" {
  description = "ControllerPolicyName"
  value       = module.ControllerPolicyName.arn
}

output "iam-WorkerComumPolicyName" {
  description = "WorkerComumPolicyName"
  value       = module.WorkerComumPolicyName.arn
}


output "iam-WorkerSystemPolicyName" {
  description = "WorkerSystemPolicyName"
  value       = module.WorkerSystemPolicyName.arn
}


output "iam-WorkerPool1PolicyName" {
  description = "WorkerPool1PolicyName"
  value       = module.ControllerPolicyName.arn
}


