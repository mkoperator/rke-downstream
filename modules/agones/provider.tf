terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.1.2"
    }
  }
}

provider "helm" {
 kubernetes {
    config_path      = var.kubeconfig_file
  }
}
provider "kubernetes" {
    config_path      = var.kubeconfig_file
  }