resource "yandex_kubernetes_node_group" "default" {
  cluster_id = yandex_kubernetes_cluster.k8s.id
  name       = "${local.project_name}-node-group"
  version    = local.kubernetes.version
  labels     = local.labels

  instance_template {
    platform_id = "standard-v3"

    resources {
      cores         = local.kubernetes.node.cores
      memory        = local.kubernetes.node.memory
      core_fraction = local.kubernetes.node.core_fraction
    }

    boot_disk {
      type = local.kubernetes.node.disk_type
      size = local.kubernetes.node.disk_size
    }

    network_interface {
      nat = true
      subnet_ids = [
        yandex_vpc_subnet.subnet_a.id,
        yandex_vpc_subnet.subnet_b.id,
        yandex_vpc_subnet.subnet_d.id
      ]
    }

    scheduling_policy {
      preemptible = local.kubernetes.node.preemptible
    }
  }

  scale_policy {
    fixed_scale {
      size = local.kubernetes.node.node_count
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }

    location {
      zone = "ru-central1-b"
    }

    location {
      zone = "ru-central1-d"
    }
  }

  maintenance_policy {
    auto_repair  = true
    auto_upgrade = true
  }

  depends_on = [
    yandex_kubernetes_cluster.k8s
  ]
}
