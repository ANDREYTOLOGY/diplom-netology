resource "yandex_container_registry" "registry" {
  name = "${local.project_name}-registry"
}
