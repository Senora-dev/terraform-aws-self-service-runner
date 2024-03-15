module "create_secret_runner"{
    source = "Senora-dev/self-service-runner/aws"
    version = "~>1.0.0"
    action_identifier = "create-secrets"
    buildspec_file = file("${path.module}/runners/buildspec.yaml")
}
