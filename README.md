## Game Server Downstream Cluster
### Initialise dependencies

```shell
$ terraform init
```

## Usage

Populate `terraform.tfvars` with your AWS access and secret key, preferred region, and the number / type of nodes you want.  For example, for a cluster with three master (controlplane and etcd) nodes and 5 workers:

```shell
node_all_count       = 0
node_master_count    = 3
node_worker_count    = 5
```

Or if you want three nodes with all roles assigned (suitable for Rancher) then:

```shell
node_all_count       = 3
node_master_count    = 0
node_worker_count    = 0
```

Then to deploy the infrastructure with Terraform:

```shell
$ terraform apply -auto-approve
module.rke_infra.aws_key_pair.rancher_key_pair: Creating...
module.rke_infra.aws_lb_target_group.rancher_lb_tg_443[0]: Creating...
module.rke_infra.aws_lb_target_group.rancher_lb_tg_80[0]: Creating...

[..]

Apply complete! Resources: 18 added, 0 changed, 0 destroyed.
```

### Deploying an NLB for Ingress

With the configured Cloud Provider we can create a Service of type LoadBalancer to front the NGINX Ingress Controller:

```shell
export KUBECONFIG=$(pwd)/kube_config_cluster.yml
```

```shell
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
    service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout: '60'
    service.beta.kubernetes.io/aws-load-balancer-proxy-protocol: '*'
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
  labels:
    k8s-addon: ingress-nginx.addons.k8s.io
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/component: controller
  name: ingress-nginx
  namespace: ingress-nginx
spec:
  externalTrafficPolicy: Cluster
  ports:
  - name: https
    port: 443
    protocol: TCP
    targetPort: http
  - name: http
    port: 80
    protocol: TCP
    targetPort: http
  selector:
    app: ingress-nginx
  type: LoadBalancer
EOF
```

```shell
$ kubectl get svc -n ingress-nginx
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP                                                                     PORT(S)                      AGE
default-http-backend   ClusterIP      10.43.188.38   <none>                                                                          80/TCP                       3m6s
ingress-nginx          LoadBalancer   10.43.200.22   a3434a29f60e34f3fba93c23c82ba0f1-cf501f266ec5cbe7.elb.eu-west-2.amazonaws.com   443:31385/TCP,80:30923/TCP   21s

$ dig +short a3434a29f60e34f3fba93c23c82ba0f1-cf501f266ec5cbe7.elb.eu-west-2.amazonaws.com
18.135.66.197
```

That's the IP of the loadbalancer now fronting the NGINX Ingress Controllers.



