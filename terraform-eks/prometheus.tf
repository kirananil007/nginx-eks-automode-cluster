resource "kubernetes_namespace" "monitoring" {
  count = var.enable_monitoring_namespace ? 1 : 0
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  count      = var.enable_monitoring_namespace ? 1 : 0
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "57.0.2"
  values = [
    file("${path.module}/values/prometheus-grafana.yaml")
  ]

  timeout          = 600
  create_namespace = false
  atomic           = true
  cleanup_on_fail  = true
}
