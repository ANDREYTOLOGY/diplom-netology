output "service_account_id" {
  value = yandex_iam_service_account.terraform.id
}

output "access_key" {
  value = yandex_iam_service_account_static_access_key.terraform.access_key
}

output "secret_key" {
  value     = yandex_iam_service_account_static_access_key.terraform.secret_key
  sensitive = true
}
