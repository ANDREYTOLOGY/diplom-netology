resource "helm_release" "ingress_nginx" {
  name  = "ingress-nginx"
  chart = "${path.module}/../ingress-nginx-4.15.1.tgz"

  namespace        = "ingress-nginx"
  create_namespace = true

  wait    = true
  timeout = 600

  depends_on = [
    yandex_kubernetes_node_group.default,
    yandex_resourcemanager_folder_iam_member.load_balancer_admin
  ]
}