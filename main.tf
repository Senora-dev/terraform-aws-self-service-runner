#################
### S3 bucket ###
#################
resource "aws_s3_bucket" "runner_bucket" {
  bucket = "s3-${var.action_identifier}"
  force_destroy = true
}

#resource "aws_s3_bucket_acl" "runner_bucket_acl" {
#  bucket = aws_s3_bucket.runner_bucket.id
#  acl    = "private"
#}

#####################
### IAM resources ###
#####################
resource "aws_iam_role" "runner_iam_role" {
  name               = "iam-${var.action_identifier }"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "runner_iam_policy" {
  role   = aws_iam_role.runner_iam_role.name
  policy = data.aws_iam_policy_document.runner_iam_policy.json
}

resource "aws_iam_role" "start_codebuild" {
  name               = "iam-role-start-codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "start_codebuild" {
  name   = "iam-policy-start-codebuild"
  policy = data.aws_iam_policy_document.start_codebuild.json
}

resource "aws_iam_role_policy_attachment" "start_codebuild" {
  policy_arn = aws_iam_policy.start_codebuild.arn
  role       = aws_iam_role.start_codebuild.name
}

#################
### CodeBuild ###
#################
resource "aws_codebuild_project" "runner_codebuild" {
  name          = "codebuild-${var.action_identifier}"
  description   = "This is the runner of the Self-Service action: ${var.action_identifier}"
  build_timeout = 5
  service_role  = aws_iam_role.runner_iam_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.runner_bucket.bucket
  }

  environment {
    compute_type                = var.codebuild_compute_type
    image                       = var.codebuild_image
    type                        = var.codebuild_type
    image_pull_credentials_type = "CODEBUILD"


    dynamic "environment_variable" {
      for_each = var.codebuild_environment_variables
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
  }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.runner_bucket.id}/build-log"
    }
  }

  source {
    type            = "NO_SOURCE"
    buildspec        = var.buildspec_file
  }

  #TBD - when vpc flag will be released.
  #vpc_config {
  #  vpc_id = aws_vpc.example.id

  #  subnets = [
  #    aws_subnet.example1.id,
  #    aws_subnet.example2.id,
  #  ]

  #  security_group_ids = [
  #    aws_security_group.example1.id,
  #    aws_security_group.example2.id,
  #  ]}

  tags = var.tags
  depends_on = [aws_s3_bucket.runner_bucket]
}