# terraform-aws-self-service-runner
This Terraform module creates an AWS CodeBuild project designed to serve as a runner for Port self-service actions. The CodeBuild project is configured to be triggered by the [Lambda Agent](https://github.com/Senora-dev/terraform-aws-self-service-agent).

## Prerequisites
- Before creating a runner (which serves as the backend for the action), ensure that you create a form and set the [trigger using Kafka](https://docs.getport.io/create-self-service-experiences/setup-backend/kafka/).
- Generate a [buildspec.yaml](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html) file containing the specifications for your action.

## Usage
Now, add the module into your Terraform code:
```terraform
module "my_runner"{
    source  = "Senora-dev/self-service-runner/aws"
    version = "~>1.0.0"
    
    action_identifier = "action_identifier_from_port_ui"
    buildspec_file = file("${path.module}/runners/sample.yaml")
}
```