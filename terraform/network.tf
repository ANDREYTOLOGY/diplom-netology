resource "yandex_vpc_network" "diplom" {
  name = "diplom-vpc"
}

resource "yandex_vpc_subnet" "subnet_a" {
  name           = "diplom-subnet-a"
  description    = "Subnet A"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet_b" {
  name           = "diplom-subnet-b"
  description    = "Subnet B"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.10.20.0/24"]
}

resource "yandex_vpc_subnet" "subnet_d" {
  name           = "diplom-subnet-d"
  description    = "Subnet D"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.diplom.id
  v4_cidr_blocks = ["10.10.30.0/24"]
}
