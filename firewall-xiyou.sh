#!/bin/bash
num=$#
ok=0
if [ ${num} != 1 ]; then
    echo 'error:you must input one parmas, parmas is close or open'
    exit 0
fi

case $1 in

close)

firewall-cmd --zone=public --remove-port=5201-5210/tcp --permanent
firewall-cmd --zone=public --remove-port=10211-10220/tcp --permanent
firewall-cmd --zone=public --remove-port=8111-8112/tcp --permanent
firewall-cmd --zone=public --remove-port=9998-9999/tcp --permanent
firewall-cmd --zone=public --remove-port=50261/tcp --permanent
firewall-cmd --zone=public --remove-port=50262/tcp --permanent


ok=1
;;

open)

firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=24046/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=8089/tcp --permanent
firewall-cmd --zone=public --add-port=53/udp --permanent
firewall-cmd --zone=public --add-port=123/udp --permanent

firewall-cmd --zone=public --add-port=5201-5210/tcp --permanent
firewall-cmd --zone=public --add-port=10211-10220/tcp --permanent
firewall-cmd --zone=public --add-port=8111-8112/tcp --permanent
firewall-cmd --zone=public --add-port=9998-9999/tcp --permanent
firewall-cmd --zone=public --add-port=50261/tcp --permanent
firewall-cmd --zone=public --add-port=50262/tcp --permanent

ok=1
;;

*)
echo 'params must be "close" or "open"' 
;;

esac
if [ ${ok} == 1 ]; then
firewall-cmd --reload
firewall-cmd --zone=public --list-all
fi
exit 0
