# funkypenguin18_infra

# ДЗ №8 (ansible-1)

* Создана инфраструктура из тестового окружения stage
* Созданы  inventory-файлы (yaml format), в которох указаны хосты appserver и dbserver

* С помощью ansible проверили установку приложений ruby и bundler, mongodb
* Создан  простой playbook clone.yml и запущен на выполнение

```
ansible-playbook clone.yml -i inventory.yml

PLAY [Clone] *************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************
ok: [appserver]

TASK [Clone repo] ********************************************************************************************
ok: [appserver]

PLAY RECAP ***************************************************************************************************
appserver                  : ok=2    changed=0    unreachable=0    failed=0   
```
Удалил приложение reddit с помощью команды ansible app -m command -a 'rm -rf ~/reddit' и запустил playbook еще раз, результат:

```
PLAY [Clone] **************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************
ok: [appserver]

TASK [Clone repo] *********************************************************************************************************************************************************************************************
changed: [appserver]

PLAY RECAP ****************************************************************************************************************************************************************************************************
appserver                  : ok=2    changed=1    unreachable=0    failed=0
```

Задание со *

Для генерации динамического inventory на лету написан скрипт inventory.py , выводящий список хостов для ansible в формате json.

# ДЗ №7 (terraform-2)

Монолитное приложение было разделено на следующие модули:
* Модуль app для деплоя приложения puma-server
* Модуль db для деплоя БД
* Модуль VPC с правилом доступа по ssh

Созданы и протестированы окружения prod и stage

Созданы два хранилища - penguin-1 penguin-2 в Google Cloud Storage

## Задание со *

Настроено хранение стейт файла в бакете GCP

В директории terraform создан файл storage-bucket.tf с описанием двух хранилищ(бакетов)
Применяется через terraform init && terraform apply

В окружениях добавлены файлы backend.tf с указанеем хранить файлы в конкретном бакете.

##Задание со **

Приложение разнесено на разные сервера, в модули добавлены необходимые провиженеры.

Через переменную db_local_ip сообщаем приложению где находится ДБ.
(Указанную переменную берем из внутреннего адреса инстанса reddit-db и подставлеяем с помощью переменной окружения DATABASE_URL в файл tmp/puma.env. Таким образом, приложение reddit знает на каком инстансе запущена БД).

# ДЗ №6 (terraform-1)

Выполнено развертование ВМ на основе образа reddit-base при помощи инструмента Terraform.
Конфигурационные файлы параметризованы при помощи переменных.

### задание со *

В метаданных дополнительно объявлен пользователь appuser1 при помощи:
```
metadata {
   ssh-keys = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}"
}
```

Для указания нескольких пользовательских ключей используется конструкция:
```
resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}appuser3:${file(var.public_key_path)}"
}
```
### Задание со ** - Баллансировка приложения
Создан файл lb.tf в котором описано создание HTTP-балансировщика с помощью методов google_compute_forwarding_rule и google_compute_target_pool.

Добавлен вывод ip-адреса балансировщика через переменную app_external_ip_lb

Для уменьшения количества кода было принято решение увеличивать количество инстансов через каунтер.

# ДЗ №5 (packer-base)
Packer:

Создан базовый образ reddit-base на основании шаблона Ubuntu16.json

Указанный шаблон настроен на работу с переменными, описанными в файле variables.json

В целях безопасности, указанный шаблон добавлен в файл .gitignore , а в репозиторий добавлена его копия variables.json.example

Указанный шаблон проверен при помощи команды

```
packer validate -var-file variables.json ./ubuntu16.json
```

Образ собран с помощью команды

```
packer build -var-file variables.json ./ubuntu16.json
```

На основании шаблона immutable.json создан bake- образ приложения reddit-full-1553641552.

Добавлен старт приложения с помощью systemd.

Также в папку /config-scripts добавлен скрипт create-reddit-vm.sh с возможностью создания и запуска инстанса с помощью команды gcloud.


# HW №3 cloud-bastion

Подключение к someinternalhost в одну команду:  ssh -i ~/.ssh/appuser -At appuser@35.211.5.229 ssh 10.142.0.3

Для подключения из консоли командой ssh someinternalhost и ssh bastion
необходимо внести следующие изменения в файл ~/.ssh/config
на локальном компьютере (создать в случае необходимости):

```
Host bastion
    HostName 35.211.5.229
    User appuser

Host someinternalhost 10.142.0.3
    User appuser
    ProxyCommand ssh -i ~/.ssh/appuser -A bastion nc -w 180 %h %p
```

bastion_IP = 35.211.5.229
someinternalhost_IP = 10.142.0.3

Let's encrypt for pritunl installed, check on:
https://35-211-5-229.sslip.io/login

Cloude-test
testapp_IP = 34.65.55.223
testapp_port = 9292

команда для startup - script:
```
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --zone europe-west3-a --metadata-from-file startup-script=startup.sh
```

команда для создания правила фаервола:
```
gcloud compute firewall-rules create default-puma-server\
 --direction=INGRESS \
 --priority=1000 \
 --network=default \
 --action=ALLOW \
 --rules=tcp:9292 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=puma-server \
 --description="Allow incoming traffic for puma-server"
```
