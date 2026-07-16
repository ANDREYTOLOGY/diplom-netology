locals {
  project_name = "diplom"

  cluster_name = "${local.project_name}-cluster"

  app_image = "cr.yandex/${yandex_container_registry.registry.id}/diplom-app:v1.0.0"


  kubernetes = {
    version = "1.33"

    node = {

      node_count    = 3
      cores         = 2
      memory        = 2
      core_fraction = 20

      disk_size = 35
      disk_type = "network-hdd"

      preemptible = true
    }
  }

  labels = {
    project = local.project_name
    managed = "terraform"
  }
}
