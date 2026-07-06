variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "bucket_name" {
  description = "Terraform state bucket name"
  type        = string
  default     = "andrey-diplom-tfstate"
}
