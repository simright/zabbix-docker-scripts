#!/bin/bash
#license:GPL
#mail:a714585725@qq.com
#date:2015.09.22
processmem(){
        sudo /usr/bin/docker exec $1 ps aux|grep $2|grep -v "grep"|grep -v "processstatus.sh"|awk '{sum+=$6}; END{print sum}'
}
processcpu(){
        sudo /usr/bin/docker exec $1 ps aux|grep $2|grep -v "grep"|grep -v "processstatus.sh"|awk '{sum+=$3}; END{print sum}'
}
processport(){
        sudo /usr/bin/docker exec $1 ss -antlp|grep $2|grep LISTEN|wc -l
}
case "$3" in
mem)
processmem $1 $2
;;
cpu)
processcpu $1 $2
;;
port)
processport $1 $2
;;
*)
echo "Usage: $0 {docker_containername}{processname}{mem|cpu|port}"
;;
esac