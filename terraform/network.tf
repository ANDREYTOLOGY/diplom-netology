# test github actions

resource "yandex_vpc_network" "diplom" {
  name = "diplom-vpc"

  labels = local.labels
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "diplom-subnet-a"
  description    = "Subnet A"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.10.10.0/24"]
  route_table_id = yandex_vpc_route_table.nat_route_table.id
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "diplom-subnet-b"
  description    = "Subnet B"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.10.20.0/24"]
  route_table_id = yandex_vpc_route_table.nat_route_table.id
}

resource "yandex_vpc_subnet" "subnet_d" {
  name           = "diplom-subnet-d"
  description    = "Subnet D"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.10.30.0/24"]
  route_table_id = yandex_vpc_route_table.nat_route_table.id
}
