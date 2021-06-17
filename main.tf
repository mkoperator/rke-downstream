resource "rancher2_cluster" "downstream_cluster" {
  name                  = var.cluster_name
  description           = "downstream cluster"
  enable_network_policy = false

  rke_config {
    kubernetes_version  = var.kubernetes_version
    cloud_provider {
      name              = "aws"
    }
    services {
      kube_api {
        secrets_encryption_config {
          enabled       = false
        }
      }
    }
  }
}
resource "rancher2_cluster_sync" "downstream_cluster" {
  cluster_id    = rancher2_cluster.downstream_cluster.id
  state_confirm = 2
}
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name                                     = "${var.prefix}-vpc"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${rancher2_cluster.downstream_cluster.id}" = "owned"
  }
}
resource "aws_subnet" "amazonia" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name                                     = "${var.prefix}-sub-amazonia"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${rancher2_cluster.downstream_cluster.id}" = "owned"
  }
}
resource "aws_subnet" "atlantis" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name                                     = "${var.prefix}-sub-atlantis"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${rancher2_cluster.downstream_cluster.id}" = "owned"
  }
}
resource "aws_subnet" "land" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name                                     = "${var.prefix}-sub-land"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${rancher2_cluster.downstream_cluster.id}" = "owned"
  }
}
module "rke_infra" {
  source                      = "./modules/rke-infra-aws"
  aws_access_key              = var.aws_access_key
  aws_secret_key              = var.aws_secret_key
  aws_region                  = var.aws_region
  prefix                      = var.aws_prefix
  aws_vpc                     = aws_vpc.main.id
  master_iam_instance_profile = var.master_iam_instance_profile
  game_iam_instance_profile   = var.game_iam_instance_profile
  svc_iam_instance_profile    = var.svc_iam_instance_profile
  clusterid                   = rancher2_cluster.downstream_cluster.id
  register_command            = rancher2_cluster.downstream_cluster.cluster_registration_token.0.node_command
  node_master_count           = var.node_master_count
  node_game_worker_count      = var.node_game_worker_count
  node_svc_worker_count       = var.node_svc_worker_count
  node_all_count              = var.node_all_count
  ssh_pub_file                = var.ssh_pub_file
  ssh_key_file                = var.ssh_key_file
}

module "monitoring" {
  source            = "./modules/monitoring"
  kubeconfig_file   = local_file.kube_config_workload_yaml.filename
  project_system_id = rancher2_cluster_sync.downstream_cluster.system_project_id
  values_yaml       = "monitoring_values.yaml"
}

module "logging" {
  source            = "./modules/logging"
  kubeconfig_file   = local_file.kube_config_workload_yaml.filename
  project_system_id = rancher2_cluster_sync.downstream_cluster.system_project_id
  values_yaml       = "logging_values.yaml"
}

module "agones" {
  source            = "./modules/agones"
  kubeconfig_file   = local_file.kube_config_workload_yaml.filename
  project_id         = rancher2_cluster_sync.downstream_cluster.default_project_id
  values_yaml       = "agones_values.yaml"
}

module "autoscaler" {
  source            = "./modules/cluster-autoscaler"
  kubeconfig_file   = local_file.kube_config_workload_yaml.filename
  project_system_id = rancher2_cluster_sync.downstream_cluster.system_project_id
}