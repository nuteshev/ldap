#!/bin/bash

hostnamectl set-hostname freeipa.otus.local
sed -i -e '$ a10.0.0.20 freeipa.otus.local' /etc/hosts

yum -y module enable idm:DL1
yum -y distro-sync
yum -y module install idm:DL1/server
yum -y module install idm:DL1/dns
yum -y module install idm:DL1/client

password="Secret123"
adminpassword="Secret456"
{
echo ""
echo ""
echo ""
echo ${password}
echo ${password}
echo ${adminpassword}
echo ${adminpassword}
echo "no"
echo "no"
echo "yes"
echo ""
echo ""
echo "yes"
} | ipa-server-install --setup-dns

systemctl enable --now firewalld
firewall-cmd --add-service=freeipa-ldap --add-service=freeipa-ldaps --permanent
firewall-cmd --add-port=53/udp --add-port=80/tcp --add-port=88/tcp --add-port=389/tcp --add-port=88/udp --add-port=464/tcp --add-port=464/tcp --add-port=123/udp  --permanent