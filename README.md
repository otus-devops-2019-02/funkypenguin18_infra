# funkypenguin18_infra
funkypenguin18 Infra repository


Подключение к someinternalhost в одну команду:  ssh -i ~/.ssh/appuser -At appuser@35.211.5.229 ssh 10.142.0.3

Для подключения из консоли командой ssh someinternalhost и ssh bastion
необходимо внести следующие изменения в файл ~/.ssh/config 
на локальном компьютере (создать в случае необходимости):

§�```
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
