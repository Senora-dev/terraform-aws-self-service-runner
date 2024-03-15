module "create_secret_runner"{
    source = "Senora-dev/self-service-runner/aws"
    version = "~>1.0.0"
    action_identifier = "simpleActionIdentifier"
    buildspec_file = templatefile("${path.module}/runners/sample.yaml", { port_client_id=module.self_service_agent.port_client_id_arn, port_client_secret=module.self_service_agent.port_client_secret_arn })
}