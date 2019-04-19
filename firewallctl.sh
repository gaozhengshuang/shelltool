#!/bin/bash
num=$#
cmd=$1

helpinfo() {
    echo 'param support:'
    echo '  firewallctl.sh blacklist 127.0.0.1'
    echo '  firewallctl.sh rmblacklist 127.0.0.1'
    echo '  firewallctl.sh whitelist 127.0.0.1'
    echo '  firewallctl.sh rmwhitelist 127.0.0.1'
    echo '  firewallctl.sh port 5201'
    echo '  firewallctl.sh rmport 5201'
    echo '  firewallctl.sh ports 5201 5210'
    echo '  firewallctl.sh rmports 5201 5210'
    echo '  firewallctl.sh ipport 8.8.8.8 6379'
    echo '  firewallctl.sh rmipport 8.8.8.8 6379'
    echo '  firewallctl.sh show'
}

checkparams() {
    need=$1
    if [ ${num} -lt $need ]; then
        echo '=========error parmas==============='
        helpinfo
        echo '=========error parmas==============='
        exit 0
    fi
}

case $cmd in
blacklist)
    checkparams 2
    ip=$2
    firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${ip}' reject"
;;
rmblacklist)
    checkparams 2
    ip=$2
    firewall-cmd --permanent --remove-rich-rule="rule family='ipv4' source address='${ip}' reject"
;;
whitelist)
    checkparams 2
    ip=$2
    firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${ip}' accept"
;;
rmwhitelist)
    checkparams 2
    ip=$2
    firewall-cmd --permanent --remove-rich-rule="rule family='ipv4' source address='${ip}' accept"
;;
port)
    checkparams 2
    port=$2
    firewall-cmd --zone=public --add-port=$port/tcp --permanent
;;
rmport)
    checkparams 2
    port=$2
    firewall-cmd --zone=public --remove-port=$port/tcp --permanent
;;
ports)
    checkparams 3
    portstart=$2
    portend=$3
    firewall-cmd --zone=public --add-port=${portstart}-${portend}/tcp --permanent
;;
rmports)
    checkparams 3
    portstart=$2
    portend=$3
    firewall-cmd --zone=public --remove-port=${portstart}-${portend}/tcp --permanent
;;
ipport)
    checkparams 3
    ip=$2
    port=$3
    firewall-cmd --permanent --add-rich-rule="rule family="ipv4" source address='${ip}' port protocol='tcp' port='${port}' accept"
;;
rmipport)
    checkparams 3
    ip=$2
    port=$3
    firewall-cmd --permanent --remove-rich-rule="rule family="ipv4" source address='${ip}' port protocol='tcp' port='${port}' accept"
;;
show)
    checkparams 1
    firewall-cmd --list-all
    exit 0
;;
*)
    helpinfo
    exit 0
;;

esac

if [[ "$cmd" != "show" ]]; then
    firewall-cmd --reload
    firewall-cmd --zone=public --list-all
    echo "firewall reload ok"
fi

