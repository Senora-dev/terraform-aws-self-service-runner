variable "action_identifier"{
    type = string
    description = "Action identifier in Port Self-Service Hub."
}

variable "buildspec_file"{
    type = string
    description = "The buildspec.yaml file which contains the commands for the CodeBuild project."
}

variable "runner_timeout"{
    type = number
    default = 60
    description = "The timeout of the Runner CodeBuild project in minutes."
}

variable "codebuild_type"{
    type = string
    default = "LINUX_CONTAINER"
    description = "Type of build environment to use for related builds. Valid values: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER (deprecated), WINDOWS_SERVER_2019_CONTAINER, ARM_CONTAINER."
}
variable "codebuild_compute_type"{
    type = string
    default = "BUILD_GENERAL1_SMALL"
    description = "Information about the compute resources the build project will use. Valid values: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE, BUILD_GENERAL1_2XLARGE. BUILD_GENERAL1_SMALL is only valid if type is set to LINUX_CONTAINER. When type is set to LINUX_GPU_CONTAINER, compute_type must be BUILD_GENERAL1_LARGE."
}

variable "codebuild_image"{
    type = string
    default = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    description = "Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/amazonlinux2-x86_64-standard:4.0), Docker Hub images (e.g., hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g., 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest)."
}

variable "codebuild_environment_variables"{
    type = map(string)
    default = {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }
    description = "A configuration block: name - (Required) Environment variable's name or key. type - (Optional) Type of environment variable. Valid values: PARAMETER_STORE, PLAINTEXT, SECRETS_MANAGER. value - (Required) Environment variable's value."
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}