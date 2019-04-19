#!/bin/bash
num=$#
cmd=$1
ip=$2
port=$2
ok=0

helpinfo() {
    echo 'param support:'
    echo '  blacklist 127.0.0.1'
    echo '  rmblacklist 127.0.0.1'
    echo '  whitelist 127.0.0.1'
    echo '  rmwhitelist 127.0.0.1'
    echo '  port 5201'
    echo '  rmport 5201'
    echo '  show'
}
if [ ${num} -lt 2 ]; then
    echo '=========error parmas==============='
    helpinfo
    echo '=========error parmas==============='
    exit 0
fi

case $cmd in
blacklist)
    firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${ip}' reject"
;;
rmblacklist)
    firewall-cmd --permanent --remove-rich-rule="rule family='ipv4' source address='${ip}' reject"
;;
whitelist)
    firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${ip}' accept"
;;
rmwhitelist)
    firewall-cmd --permanent --remove-rich-rule="rule family='ipv4' source address='${ip}' accept"
;;
port)
    firewall-cmd --zone=public --add-port=$port/tcp --permanent
;;
rmport)
    firewall-cmd --zone=public --remove-port=$port/tcp --permanent
;;
show)
    firewall-cmd --list-all
    exit 0
;;
*)
    helpinfo
    exit 0
;;

esac

firewall-cmd --reload
firewall-cmd --zone=public --list-all

