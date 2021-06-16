resource "kubernetes_namespace" "agones_system" {
  metadata {
    annotations = {
      "field.cattle.io/projectId" = var.project_id
    }
 name = "agones-system"
  }
}
resource "helm_release" "agones" {
  name       = "agones"
  repository = "https://agones.dev/chart/stable"
  chart      = "agones"
  namespace  = "agones-system"
  depends_on = [kubernetes_namespace.agones_system]
  timeout    = 600
  reuse_values = true
  values     = [
    "${file(var.values_yaml)}"
  ]
}