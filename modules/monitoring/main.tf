resource "kubernetes_namespace" "cattle_monitoring_system" {
  metadata {
    annotations = {
      "field.cattle.io/projectId" = var.project_system_id
    }
 name = "cattle-monitoring-system"
  }
}
resource "kubernetes_namespace" "cattle_dashboards" {
  metadata {
    annotations = {
      "field.cattle.io/projectId" = var.project_system_id
    }
 name = "cattle-dashboards"
  }
}
resource "helm_release" "monitoring_crd" {
  name       = "rancher-monitoring-crd"
  repository = "https://charts.rancher.io"
  chart      = "rancher-monitoring-crd"
  namespace  = "cattle-monitoring-system"
  version    = "9.4.203"
  depends_on = [kubernetes_namespace.cattle_monitoring_system]
}
resource "helm_release" "monitoring" {
  namespace  = "cattle-monitoring-system"
  name       = "rancher-monitoring"
  repository = "https://charts.rancher.io"
  chart      = "rancher-monitoring"
  version    = "9.4.203"
  depends_on = [helm_release.monitoring_crd]
  values     = [
    "${file(var.values_yaml)}"
  ]
}