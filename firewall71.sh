#!/bin/bash
num=$#
ok=0
if [ ${num} != 1 ]; then
    echo 'error:you must input one parmas, parmas is close or open'
    exit 0
fi

case $1 in

close)
#firewall-cmd --zone=public --add-port=$2/tcp --permanent
#firewall-cmd --zone=public --add-port=$2/udp --permanent


firewall-cmd --zone=public --remove-port=7002/tcp --permanent
firewall-cmd --zone=public --remove-port=7011/tcp --permanent
firewall-cmd --zone=public --remove-port=8080/tcp --permanent
firewall-cmd --zone=public --remove-port=7001/tcp --permanent
firewall-cmd --zone=public --remove-port=8023/tcp --permanent
firewall-cmd --zone=public --remove-port=8013/tcp --permanent
firewall-cmd --zone=public --remove-port=8033/tcp --permanent
firewall-cmd --zone=public --remove-port=8010/tcp --permanent
firewall-cmd --zone=public --remove-port=8003/tcp --permanent

firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.72"  port port="8006" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.73"  port port="8006" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.72"  port port="6379" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.72"  port port="3306" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.72"  port port="8001" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.73"  port port="8005" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.72"  port port="8005" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.73"  port port="8001" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.73"  port port="6379" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="210.73.214.73"  port port="3306" protocol="tcp" accept' --permanent

firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="7002" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="7011" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="8080" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="7001" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="8023" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="8013" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="8033" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="8010" protocol="tcp" accept' --permanent
firewall-cmd --add-rich-rule='rule family="ipv4" source address="116.226.126.57" port port="8003" protocol="tcp" accept' --permanent


ok=1
;;

open)
#firewall-cmd --zone=public --remove-port=$2/tcp --permanent
#firewall-cmd --zone=public --remove-port=$2/udp --permanent

firewall-cmd --zone=public --add-port=7002/tcp --permanent
firewall-cmd --zone=public --add-port=7011/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --zone=public --add-port=7001/tcp --permanent
firewall-cmd --zone=public --add-port=8023/tcp --permanent
firewall-cmd --zone=public --add-port=8013/tcp --permanent
firewall-cmd --zone=public --add-port=8033/tcp --permanent
firewall-cmd --zone=public --add-port=8010/tcp --permanent
firewall-cmd --zone=public --add-port=8003/tcp --permanent


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
