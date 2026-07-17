variable "yc_token" {
  sensitive = true
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  default = "ru-central1-a"
}

variable "kubernetes_version" {
  type    = string
  default = "1.33"
}

variable "app_image_tag" {
  description = "Docker image tag for application"
  type        = string
  default     = "v1.0.0"
}

variable "container_registry_id" {
  description = "ID Container Registry"
  type        = string
}
