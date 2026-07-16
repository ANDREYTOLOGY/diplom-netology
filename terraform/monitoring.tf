resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  chart = "./../kube-prometheus-stack-87.16.1.tgz"

  timeout = 900
  wait    = true

  set = [
    {
      name  = "grafana.ingress.enabled"
      value = "true"
    },
    {
      name  = "grafana.ingress.ingressClassName"
      value = "nginx"
    },
    {
      name  = "grafana.ingress.path"
      value = "/grafana"
    },
    {
      name  = "grafana.ingress.pathType"
      value = "Prefix"
    },
    {
      name  = "grafana.grafana\\.ini.server.root_url"
      value = "%(protocol)s://%(domain)s/grafana"
    },
    {
      name  = "grafana.grafana\\.ini.server.serve_from_sub_path"
      value = "true"
    }
  ]

  depends_on = [
    yandex_kubernetes_node_group.default,
    helm_release.ingress_nginx
  ]
}