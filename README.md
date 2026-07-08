# "`Дипломный практикум в Yandex.Cloud`" - `Чернышов Андрей`

### Задание 1. Создание облачной инфраструктуры

### Структура проекта

Проект разделен на две независимые части.

Создана виртуальная сеть и три подсети в разных зонах доступности.
`bootstrap/`

Содержит конфигурацию Terraform, предназначенную для создания базовой инфраструктуры, необходимой для работы основного проекта. 

Создаются следующие ресурсы:

- Service Account;
- IAM-роли;
- KMS;
- Object Storage (S3 Backend).

После выполнения `bootstrap` основной Terraform использует созданный Object Storage для хранения своего состояния.

 `terraform/`

Содержит конфигурацию основной инфраструктуры проекта.

Создаются следующие ресурсы:

- VPC;
- три подсети в разных зонах доступности;
- Container Registry;
- Managed Kubernetes Cluster;
- Node Group;
- IAM Service Accounts.


### Выполненные этапы

 Bootstrap (`bootstrap/`)

Созданы базовые ресурсы для дальнейшей работы Terraform.

| Файл | Назначение |
|------|------------|
| `provider.tf` | Настройка провайдера |
| `versions.tf` | Версия Terraform и Provider |
| `variables.tf` | Переменные проекта |
| `iam.tf` | Service Account, IAM-роли и Static Access Key |
| `kms.tf` | Создание KMS Key |
| `bucket.tf` | Создание Object Storage для Terraform State |
| `outputs.tf` | Вывод идентификаторов ресурсов |

---

Создан сервисный аккаунт Terraform с необходимыми IAM-ролями.

![Service Account](img/service-account.png)  

Создан Object Storage для хранения Terraform State.

![Storage](img/storage_bucket.png)

 Основная инфраструктура (`terraform/`)

| Файл | Назначение |
|------|------------|
| `backend.tf` | Подключение удаленного backend |
| `providers.tf` | Настройка провайдера Yandex Cloud |
| `versions.tf` | Версия Terraform и Provider |
| `variables.tf` | Переменные проекта |
| `locals.tf` | Общие параметры проекта |
| `network.tf` | VPC и три подсети |
| `registry.tf` | Yandex Container Registry |
| `iam.tf` | Service Accounts и IAM-роли Kubernetes |
| `k8s.tf` | Managed Kubernetes Cluster |
| `node-group.tf` | Kubernetes Node Group |
| `outputs.tf` | Вывод информации о созданной инфраструктуре |


Создана виртуальная сеть и три подсети в разных зонах доступности.

![Network](img/network_subnet.png)

### Задание 2. Создание Kubernetes кластера 

Для выполнения задания был выбран сервис **Yandex Managed Service for Kubernetes**.

С помощью Terraform был развернут Kubernetes-кластер со следующими параметрами:

- региональный мастер Kubernetes;
- три worker-ноды, размещенные в разных зонах доступности (`ru-central1-a`, `ru-central1-b`, `ru-central1-d`);
- прерываемые виртуальные машины (Preemptible) для снижения стоимости инфраструктуры;
- конфигурация worker-нод:
  - 2 vCPU;
  - 2 ГБ RAM;
  - доля CPU 20%;
  - HDD-диск объемом 35 ГБ.

После создания кластера были получены учетные данные для подключения через `kubectl` и выполнена проверка его работоспособности.

Кластер успешно создан и находится в состоянии **Running**.

![Kubernetes Cluster](img/kubernetes_cluster.png)

Проверка зарегистрированных узлов кластера: 

![Kubectl get nodes](img/kubectl_get_nodes.png)

Проверка системных компонентов:

![Kubectl get pods -A](img/kubectl_get_pods.png)

