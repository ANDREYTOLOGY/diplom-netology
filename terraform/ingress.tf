resource "helm_release" "ingress_nginx" {
  name  = "ingress-nginx"
  chart = "${path.module}/../ingress-nginx-4.15.1.tgz"

  namespace        = "ingress-nginx"
  create_namespace = true

  wait    = true
  timeout = 600

  set = [
    {
      name  = "controller.service.loadBalancerIP"
      value = yandex_vpc_address.ingress.external_ipv4_address[0].address
    }
  ]

  depends_on = [
    yandex_kubernetes_node_group.default,
    yandex_resourcemanager_folder_iam_member.load_balancer_admin,
    yandex_vpc_address.ingress
  ]
}
