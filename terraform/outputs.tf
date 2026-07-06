output "network_id" {
  description = "VPC ID"
  value       = yandex_vpc_network.diplom.id
}

output "subnet_a_id" {
  description = "Subnet A ID"
  value       = yandex_vpc_subnet.subnet_a.id
}

output "subnet_b_id" {
  description = "Subnet B ID"
  value       = yandex_vpc_subnet.subnet_b.id
}

output "subnet_d_id" {
  description = "Subnet D ID"
  value       = yandex_vpc_subnet.subnet_d.id
}
