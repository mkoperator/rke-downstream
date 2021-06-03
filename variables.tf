variable cluster_name {
  default = "rke"
}

variable clusterid {
  default = ""
}

variable kubernetes_version {
  default = "v1.19.2-rancher1-1"
}

variable aws_access_key {
  default = ""
}

variable aws_secret_key {
  default = ""
}

variable aws_prefix {
  default = ""
}

variable node_all_count {
  default = 1
}

variable node_master_count {
  default = 0
}

variable node_worker_count {
  default = 0
}

variable aws_region {
  default = "us-east-1"
}

variable iam_instance_profile {
  default = "rancher-node"
}
