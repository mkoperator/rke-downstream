# Game Server Downstream Cluster
## Usage
### Initialize
```shell
$ terraform init
```

### Configure
cluster_name                = Name of the cluster in AWS, Rancher

aws_prefix                  = Prefix for resources in AWS

aws_access_key              = IAM Role access key to run terraform

aws_secret_key              = IAM Role secret key to run terraform

aws_region                  = region to spin up vpc

node_all_count              = All in One node count

node_master_count           = Master Node Count

node_game_worker_count      = Number of Game Workers

node_svc_worker_count       = Number of Service Workers

rancher_token               = Token to add cluster to rancher, must not be scoped

rancher_server_url          = Url of Rancher control plane

master_iam_instance_profile = IAM role to bestore onto master and aio instances, must have permission

svc_iam_instance_profile    = IAM role to bestore onto service instances, must have permission

game_iam_instance_profile   = IAM role to bestore onto game instances, must have permission
