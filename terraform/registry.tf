resource "yandex_container_registry" "registry" {
  name = "${local.project_name}-registry"

  labels = local.labels
  lifecycle {
    prevent_destroy = true
  }
}
