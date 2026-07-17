resource "yandex_container_registry" "registry" {
  name = "diplom-registry"

  labels = {
    project = "diplom"
    managed = "terraform"
  }
}
