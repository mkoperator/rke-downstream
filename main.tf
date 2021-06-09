resource "rancher2_cluster" "downstream_cluster" {
  name                  = var.cluster_name
  description           = "downstream cluster"
  enable_network_policy = false

  rke_config {
 #   kubernetes_version = var.downstream_kubernetes_version
    cloud_provider {
      name = "aws"
    }
    services {
      kube_api {
        secrets_encryption_config {
          enabled = false
        }
      }
    }
  }
}

module "rke_infra" {
  source = "./modules/rke-infra-aws"

  aws_access_key       = var.aws_access_key
  aws_secret_key       = var.aws_secret_key
  aws_region           = var.aws_region
  prefix               = var.aws_prefix
  iam_instance_profile = var.iam_instance_profile
  clusterid            = rancher2_cluster.downstream_cluster.id
  register_command     = rancher2_cluster.downstream_cluster.cluster_registration_token.0.node_command
  node_master_count = var.node_master_count
  node_worker_count = var.node_worker_count
  node_all_count    = var.node_all_count
  ssh_pub_file      = var.ssh_pub_file
  ssh_key_file      = var.ssh_key_file

  deploy_lb = true 
}
