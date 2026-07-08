resource "yandex_kubernetes_cluster" "k8s" {
  name       = local.cluster_name
  network_id = yandex_vpc_network.diplom.id
  labels     = local.labels

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = "ru-central1-a"
        subnet_id = yandex_vpc_subnet.subnet_a.id
      }

      location {
        zone      = "ru-central1-b"
        subnet_id = yandex_vpc_subnet.subnet_b.id
      }

      location {
        zone      = "ru-central1-d"
        subnet_id = yandex_vpc_subnet.subnet_d.id
      }
    }

    version   = var.kubernetes_version
    public_ip = true
  }

  service_account_id      = yandex_iam_service_account.k8s_cluster.id
  node_service_account_id = yandex_iam_service_account.k8s_node.id

  release_channel = "REGULAR"

  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_cluster_agent,
    yandex_resourcemanager_folder_iam_member.vpc_public_admin,
    yandex_resourcemanager_folder_iam_member.images_puller
  ]
}
