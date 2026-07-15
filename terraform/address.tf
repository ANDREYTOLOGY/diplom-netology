resource "yandex_vpc_address" "ingress" {
  name = "${local.project_name}-ingress-ip"

  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}
