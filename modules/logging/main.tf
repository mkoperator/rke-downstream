resource "kubernetes_namespace" "cattle_logging_system" {
  metadata {
    annotations = {
      "field.cattle.io/projectId" = var.project_system_id
    }
 name = "cattle-logging-system"
  }
}
resource "helm_release" "logging_crd" {
  name       = "rancher-logging-crd"
  repository = "https://charts.rancher.io"
  chart      = "rancher-logging-crd"
  namespace  = "cattle-logging-system"
  version    = "3.8.203"
  depends_on = [kubernetes_namespace.cattle_logging_system]
}
resource "helm_release" "logging" {
  namespace  = "cattle-logging-system"
  name       = "rancher-logging"
  repository = "https://charts.rancher.io"
  chart      = "rancher-logging"
  version    = "3.8.203"
  depends_on = [helm_release.logging_crd]
}