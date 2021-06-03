module "rke_infra" {
  source = "./modules/rke-infra-aws"

  aws_access_key       = var.aws_access_key
  aws_secret_key       = var.aws_secret_key
  aws_region           = var.aws_region
  prefix               = var.aws_prefix
  iam_instance_profile = var.iam_instance_profile
  clusterid            = var.clusterid

  node_master_count = var.node_master_count
  node_worker_count = var.node_worker_count
  node_all_count    = var.node_all_count

  deploy_lb = true 
}
