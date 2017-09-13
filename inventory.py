#!/usr/bin/env python
#-*- coding: utf-8 -*-

import psutil
import sys


class cpu(object):
    def __init__(self, attr, per):
        per = eval(per)
        if attr == 'count':
            _value = psutil.cpu_count(logical=per) #per为True时为逻辑核数，为False时为物理核数
        elif attr == 'percent':
            _value = psutil.cpu_percent()
        else:
            _cpu_times = psutil.cpu_times(percpu=per) #是否按百分比显示
            _value = _cpu_times.__getattribute__(attr)
        setattr(self, attr, _value)

class mem(object):
    def __init__(self, attr, per):
        _mem = psutil.virtual_memory()
        _value = (float(_mem.__getattribute__(attr)) / _mem.__getattribute__('total') * 100) if eval(per) else _mem.__getattribute__(attr)
        setattr(self, attr, _value)

class net(object):
    """docstring for net"""
    def __init__(self, attr, per):
        super(net, self).__init__()
        per = eval(per)
        setattr(self, attr, psutil.net_io_counters().__getattribute__(attr))

        
def get_inventory_by_name(inventory_type, inventory_name, per):
    return obj.get(inventory_type)(inventory_name, per).__getattribute__(inventory_name)


obj = {
    'cpu': cpu,
    'mem': mem,
    'net': net,
    # 'disk': disk
}

if __name__ == "__main__":
    inventory_type = sys.argv[1] #cpu/mem/network
    inventory_name = sys.argv[2] #具体指标
    inventory_per  = sys.argv[3] #百分比显示
    print get_inventory_by_name(inventory_type, inventory_name, inventory_per)