# downstream2 administration provider
provider "rancher2" {

  api_url  = var.rancher_server_url
  # ca_certs  = data.kubernetes_secret.downstream_cert.data["ca.crt"]
  token_key = var.rancher_token
}
provider "aws" {


  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
