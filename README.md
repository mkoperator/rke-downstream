# Game Server Downstream Cluster
## Usage
### Initialize
```shell
$ terraform init
```

### Run
You'll hae to run the apply and then say "yes" to accept the changes. If you are feeling dangerous, do `--auto-approve`
```shell
$ terraform apply
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


## System Components

main.tf - main runner file, instantiates Rancher connection and creates downstream cluster. Directs aws to create infrastructure and then deploys services.

proivder.tf - defines settings to connect with rancher and load aws.

modules - directory of modules

rke-ifra-aws/ - module responsible for AWS provisioning bits.

agones/ - agones module

logging/ - logging module

monitoring/ - monitoring module

cluster-autoscaler/ - not currently included.