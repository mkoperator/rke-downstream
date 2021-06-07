# downstream2 administration provider
provider "rancher2" {
  alias = "admin"

  api_url  = var.rancher_server_url
  insecure = true
  # ca_certs  = data.kubernetes_secret.downstream_cert.data["ca.crt"]
  token_key = var.rancher_token
}