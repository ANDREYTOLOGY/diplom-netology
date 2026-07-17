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

### Задание 3. Создание тестового приложения

В рамках данного этапа было подготовлено тестовое веб-приложение на базе nginx, отдающее статическую HTML-страницу.

Структура приложения:

| Файл | Назначение |
|------|------------|
| `Dockerfile` | Сборка Docker-образа на базе nginx |
| `nginx.conf` | Конфигурация веб-сервера nginx |
| `index.html` | Статическая страница тестового приложения |

Для проверки состояния приложения реализован endpoint `/health`, возвращающий HTTP-ответ `200 OK`.

Docker-образ приложения был собран и опубликован в Yandex Container Registry:

`cr.yandex/${REGISTRY_ID}/diplom-app:v1.0.0`

Проверка наличия образа в Container Registry:

![Container Registry Image](img/container_registry.png)

### Задание 4. Деплой приложения в Kubernetes

Для развертывания тестового приложения были подготовлены Kubernetes-манифесты.

| Файл | Назначение |
|------|------------|
| `namespace.yaml` | Создание отдельного namespace `diplom-app` |
| `deployment.yaml` | Развертывание двух реплик тестового приложения |
| `service.yaml` | Создание внутреннего сервиса типа `ClusterIP` |

Приложение развернуто в двух репликах. Для контейнеров настроены:

- `readinessProbe` для проверки готовности приложения к приему трафика;
- `livenessProbe` для контроля работоспособности контейнеров;
- ограничения на использование CPU и оперативной памяти;
- endpoint `/health`, возвращающий HTTP-код `200 OK`.

Проверка состояния подов:

![Kubernetes Application Pods](img/kubernetes_app_pods.png)

Проверка доступности приложения и health endpoint:

![Kubernetes Application Health](img/kubernetes_app_health.png)

Для обеспечения внешнего доступа к приложению был установлен Nginx Ingress Controller.

Установка Ingress Controller автоматизирована с помощью Terraform и Helm Provider. Terraform подключается непосредственно к создаваемому Managed Kubernetes Cluster и устанавливает Helm chart `ingress-nginx` после создания группы worker-нод.

Для повышения воспроизводимости инфраструктуры Helm chart `ingress-nginx` версии `4.15.1` хранится локально в репозитории проекта. 

Сервис Ingress Controller имеет тип `LoadBalancer`. Yandex Cloud автоматически создает внешний Network Load Balancer и назначает публичный IP-адрес.

Приложение доступно извне по HTTP на стандартном порту `80`.

Проверка внешнего доступа к приложению:

![Kubernetes Application External Access](img/kubernetes_app_external.png)

Проверка Ingress и внешнего Load Balancer:

![Kubernetes Ingress](img/kubernetes_ingress.png)


### Задание 5. Развертывание системы мониторинга

Для мониторинга Kubernetes-кластера используется `kube-prometheus-stack`, устанавливаемый автоматически с помощью Terraform и Helm Provider.

Используется Helm-чарт версии `87.16.1`.

В состав системы мониторинга входят:

- Prometheus;
- Grafana;
- Alertmanager;
- Prometheus Operator;
- kube-state-metrics;
- node-exporter.

`node-exporter` автоматически развернут на каждой из трех worker-нод Kubernetes-кластера.

Grafana опубликована через NGINX Ingress и доступна по адресу:

```
http://<EXTERNAL_IP>/grafana
```

После установки автоматически импортируются готовые Dashboard для Kubernetes.

![Grafana Dashboard](grafana-dashboards.png)

### Задание 6. CI/CD

Для автоматизации используются два GitHub Actions Workflow.

#### Terraform


При изменении файлов каталога `terraform/` автоматически выполняются:

- terraform init
- terraform validate
- terraform plan
- terraform apply

Инфраструктура поддерживается в актуальном состоянии.

![Terraform Workflow](terraform_workflow.png)

#### Docker CI/CD

При каждом коммите:

- собирается Docker Image;
- публикуется в Yandex Container Registry;
- создаётся тег по SHA коммита;
- автоматически обновляется Deployment Kubernetes;
- выполняется Rolling Update приложения.

![Terraform Workflow](docker_workflow.png)
