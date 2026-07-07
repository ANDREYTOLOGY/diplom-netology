resource "yandex_iam_service_account" "k8s_cluster" {
  name        = "${local.project_name}-k8s-cluster"
  description = "Service account for Managed Kubernetes cluster"
}

resource "yandex_iam_service_account" "k8s_node" {
  name        = "${local.project_name}-k8s-node"
  description = "Service account for Kubernetes node group"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_cluster_agent" {
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_public_admin" {
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images_puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_node.id}"
}
