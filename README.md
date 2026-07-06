# "`Дипломный практикум в Yandex.Cloud`" - `Чернышов Андрей`

### Задание 1. Создание облачной инфраструктуры

### Структура проекта

Проект разделен на две независимые части.

`bootstrap/`

Содержит конфигурацию Terraform, предназначенную для создания базовой инфраструктуры, необходимой для работы основного проекта:

- Service Account;
- IAM-роли;
- KMS;
- Object Storage (S3 Backend).

После выполнения `bootstrap` основной Terraform использует созданный Object Storage для хранения своего состояния.

 `terraform/`

Содержит конфигурацию основной инфраструктуры проекта:

- VPC;
- подсети;
- Security Groups;
- Managed Kubernetes;
- Container Registry;
- остальные облачные ресурсы.


### Выполненные этапы

 Bootstrap (`bootstrap/`)

Созданы базовые ресурсы для дальнейшей работы Terraform.

| Файл | Назначение |
|------|------------|
| `iam.tf` | Service Account, IAM-роли, Static Access Key |
| `kms.tf` | Создание KMS-ключа |
| `bucket.tf` | Создание Object Storage для Terraform State |
| `outputs.tf` | Вывод идентификаторов созданных ресурсов |

---

Создан сервисный аккаунт Terraform с необходимыми IAM-ролями.

![Service Account](img/service-account.png)  

Создан сервисный аккаунт Terraform с необходимыми IAM-ролями.

![Service Account](img/service-account.png)  

 Основная инфраструктура (`terraform/`)

| Файл | Назначение |
|------|------------|
| `backend.tf` | Подключение удаленного backend |
| `providers.tf` | Настройка провайдера Yandex Cloud |
| `versions.tf` | Версии Terraform и Provider |
| `variables.tf` | Переменные проекта |
| `network.tf` | Создание VPC и трех подсетей |
| `security.tf` | Security Groups *(в разработке)* |
| `registry.tf` | Container Registry *(в разработке)* |
| `kubernetes.tf` | Managed Kubernetes *(в разработке)* |

Создана виртуальная сеть и три подсети в разных зонах доступности.

![Network](img/network_subnet.png)
