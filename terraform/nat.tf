resource "yandex_vpc_gateway" "nat_gateway" {
  name = "${local.project_name}-nat-gateway"

  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat_route_table" {
  name       = "${local.project_name}-nat-route-table"
  network_id = yandex_vpc_network.diplom.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}
