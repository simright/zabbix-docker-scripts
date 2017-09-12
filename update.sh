#!/bin/bash

sudo sed -i '$d' /etc/zabbix/zabbix_agentd.conf
sudo echo 'UserParameter=inventory[*],sudo /usr/bin/python /home/ubuntu/simright/zabbix/scripts/inventory.py $1 $2 $3' >> /etc/zabbix/zabbix_agentd.conf
sudo kill $(awk '{print $2}' <(sudo ps aux | grep "zabbix_agentd$"))
sudo zabbix_agentd
