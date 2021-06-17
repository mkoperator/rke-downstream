# AWS infrastructure resources

# Create Nodes
resource "aws_instance" "node_master" {
  count                       = var.node_master_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.downstream_key_pair.key_name
  iam_instance_profile        = var.master_iam_instance_profile
  vpc_security_group_ids      = [aws_security_group.master_nodes.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.available.ids), 0)
  associate_public_ip_address = true
  user_data                   = "${local.node_master_cloudinit} --node-name ${var.prefix}-node-master-${count.index}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = var.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
  tags = {
    Name                                     = "${var.prefix}-node-master-${count.index}"
    K8sRoles                                 = "controlplane,etcd"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_instance" "node_svc_worker" {
  count                       = var.node_svc_worker_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.downstream_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.svc_nodes.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.available.ids), 0)
  associate_public_ip_address = true
  user_data                   = "${local.node_svc_worker_cloudinit} --node-name ${var.prefix}-node-svc-${count.index}"
  iam_instance_profile        = var.svc_iam_instance_profile
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = var.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
  tags = {
    Name                                     = "${var.prefix}-node-svc-${count.index}"
    K8sRoles                                 = "worker"
    NodeRole                                 = "service"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_instance" "node_game_worker" {
  count                       = var.node_game_worker_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.downstream_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.game_nodes.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.available.ids), 0)
  associate_public_ip_address = true
  user_data                   = "${local.node_game_worker_cloudinit} --node-name ${var.prefix}-node-game-${count.index}"
  iam_instance_profile        = var.game_iam_instance_profile
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = var.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
  tags = {
    Name                                     = "${var.prefix}-node-game-${count.index}"
    K8sRoles                                 = "worker"
    NodeRole                                 = "game"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_instance" "node_all" {
  count                       = var.node_all_count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.downstream_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.master_nodes.id, aws_security_group.svc_nodes.id, aws_security_group.game_nodes.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.available.ids), 0)
  associate_public_ip_address = true
  user_data                   = "${local.node_all_cloudinit} --node-name ${var.prefix}-node-aio-${count.index}"
  iam_instance_profile        = var.master_iam_instance_profile
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
  }
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = var.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
  tags = {
    Name                                     = "${var.prefix}-node-aio-${count.index}"
    K8sRoles                                 = "controlplane,etcd,worker"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
  lifecycle {
    create_before_destroy = true
  }
}
