# funkypenguin18_infra
funkypenguin18 Infra repository

����������� � someinternalhost � ���� �������:  ssh -i ~/.ssh/appuser -At appuser@35.211.5.229 ssh 10.142.0.3

��� ����������� �� ������� �������� ssh someinternalhost � ssh bastion
���������� ������ ��������� ��������� � ���� ~/.ssh/config 
�� ��������� ���������� (������� � ������ �������������):

Host bastion
    HostName 35.211.5.229
    User appuser

Host someinternalhost 10.142.0.3
    User appuser
    ProxyCommand ssh -i ~/.ssh/appuser -A bastion nc -w 180 %h %p

bastion_IP = 35.211.5.229
someinternalhost_IP = 10.142.0.3
