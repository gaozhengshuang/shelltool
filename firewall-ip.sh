#!/bin/bash
num=$#
cmd=$1
port=$2
ok=0
if [ ${num} -lt 1 ]; then
    echo 'error:you must input at least one parmas'
    exit 0
fi

case $cmd in

close)
    firewall-cmd --permanent --remove-rich-rule="rule family='ipv4' source address='192.168.30.0/24' accept"
    ok=1
;;

open)
    firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.30.0/24' accept"
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
