#!/bin/bash

host=`hostname`
regex="*.otus.local"
if [[ ! $host =~ $regex ]]; then 
	hostnamectl set-hostname ${host}.otus.local
	addr=`ip a show dev eth1  | grep "inet " | awk '{print $2}' | awk -F '/' '{print $1}'`
	sed -i -e "\$ a${addr} ${host}.otus.local ${host}" /etc/hosts
fi
systemctl enable --now firewalld
firewall-cmd --add-port=80/tcp --add-port=88/tcp --add-port=389/tcp --add-port=88/udp  --add-port=464/tcp --add-port=123/udp --permanent
{
echo "";
echo "yes";
 } | ipa-client-install --domain otus.local -p admin -w "Secret456" --force-join
authselect enable-feature with-mkhomedir
systemctl enable --now oddjobd.service