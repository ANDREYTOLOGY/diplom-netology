resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  chart = "./../kube-prometheus-stack-87.16.1.tgz"

  timeout = 900
  wait    = true

  depends_on = [
    yandex_kubernetes_node_group.default,
    helm_release.ingress_nginx
  ]
}
