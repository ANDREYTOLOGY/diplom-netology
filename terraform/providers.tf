provider "yandex" {
  
  token = var.yc_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

data "yandex_client_config" "client" {}

provider "helm" {
  kubernetes = {
    host                   = yandex_kubernetes_cluster.k8s.master[0].external_v4_endpoint
    cluster_ca_certificate = yandex_kubernetes_cluster.k8s.master[0].cluster_ca_certificate
    token                  = data.yandex_client_config.client.iam_token
  }
}
provider "kubernetes" {
  host                   = yandex_kubernetes_cluster.k8s.master[0].external_v4_endpoint
  cluster_ca_certificate = yandex_kubernetes_cluster.k8s.master[0].cluster_ca_certificate
  token                  = data.yandex_client_config.client.iam_token
}

