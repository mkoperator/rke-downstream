locals {
  user_data             = var.user_data != "" ? var.user_data : <<-EOT
    #!/bin/bash -x

    curl -sL https://releases.rancher.com/install-docker/${var.docker_version}.sh | sh
    sudo usermod -aG docker ${var.node_username}
  EOT
  node_all_cloudinit    = <<-EOT
    ${local.user_data}
    ${var.register_command} --etcd --controlplane --worker \
  EOT
  node_master_cloudinit = <<-EOT
    ${local.user_data}
    ${var.register_command} --etcd --controlplane \
  EOT
  node_svc_worker_cloudinit = <<-EOT
    ${local.user_data}
    ${var.register_command} --worker --label type=service \
  EOT
  node_game_worker_cloudinit = <<-EOT
    ${local.user_data}
    ${var.register_command} --worker --label agones.dev/agones-system=true --taints agones.dev/agones-system=true:NoExecute \
  EOT
  tags = {
    TFModule = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "shared"
  }
}
