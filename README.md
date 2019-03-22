# funkypenguin18_infra
funkypenguin18 Infra repository


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

testapp_ip = 34.65.55.223
testapp_post = 9292

команда для startup - script:
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --zone europe-west3-a --metadata-from-file startup-script=startup.sh

команда для создания правила фаервола:

gcloud compute firewall-rules create default-puma-server\
 --direction=INGRESS \
 --priority=1000 \
 --network=default \
 --action=ALLOW \
 --rules=tcp:9292 \
 --source-ranges=0.0.0.0/0 \
 --target-tags=puma-server \
 --description="Allow incoming traffic for puma-server"
