# funkypenguin18_infra

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
