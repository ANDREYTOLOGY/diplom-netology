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

output "container_registry_id" {
  value = var.container_registry_id
}

output "container_registry_url" {
  value = "cr.yandex/${var.container_registry_id}"
}

output "kubernetes_cluster_id" {
  description = "Managed Kubernetes cluster ID"
  value       = yandex_kubernetes_cluster.k8s.id
}

output "kubernetes_cluster_name" {
    description = "Managed Kubernetes cluster name"	
  value = yandex_kubernetes_cluster.k8s.name

}
