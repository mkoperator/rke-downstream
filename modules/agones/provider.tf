terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.1.2"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.11.1"
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

provider "kubectl" {
    config_path      = var.kubeconfig_file
}