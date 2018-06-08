#!/bin/bash
num=$#
cmd=$1
port=$2
ok=0
if [ ${num} -lt 1 ]; then
    echo 'error:you must input at least one parmas, parmas1 is "close/open/list"; parmas2 is port number'
    exit 0
fi

case $cmd in

close)
if [ ${num} -ne 2 ]; then
    echo 'error: you must input parmas2 which is port number'
    exit 0
fi
firewall-cmd --zone=public --remove-port=$port/tcp --permanent
ok=1
;;

open)
if [ ${num} -ne 2 ]; then
    echo 'error: you must input parmas2 which is port number'
    exit 0
fi
firewall-cmd --zone=public --add-port=$port/tcp --permanent
ok=1
;;

list)
    firewall-cmd --list-all
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
