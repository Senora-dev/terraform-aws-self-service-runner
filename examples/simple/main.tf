module "create_secret_runner"{
    source = "Senora-dev/self-service-runner/aws"
    version = "~>1.0.0"
    action_identifier = "simpleActionIdentifier"
    buildspec_file = file("${path.module}/buildspec.yaml")
}