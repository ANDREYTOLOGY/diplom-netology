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
