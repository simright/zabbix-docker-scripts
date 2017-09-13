#!/bin/bash

sudo kill $(awk '{print $2}' <(sudo ps aux | grep "zabbix_agentd$"))
sudo zabbix_agentd
