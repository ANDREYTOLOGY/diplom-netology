resource "yandex_kms_symmetric_key" "terraform_state" {
  name              = "diplom-kms"
  description       = "KMS key for Terraform state bucket"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год
}
