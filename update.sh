#!/bin/bash

sudo echo 'UserParameter=inventory[*],sudo /bin/bash /home/ubuntu/simright/zabbix/scripts/inventory.py $1 $2 $3' >> /etc/zabbix/zabbix_agentd.conf
sudo kill $(awk '{print $2}' <(sudo ps aux | grep "zabbix_agentd$"))
sudo zabbix_agentd
