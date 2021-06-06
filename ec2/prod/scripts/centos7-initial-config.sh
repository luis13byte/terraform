#!/bin/bash

# Para AMI Centos 7, de Amazon

sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sed -i "s/no-port-forwarding.*sleep10//g" /root/.ssh/authorized_keys

sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

echo "127.0.0.1       ${SERVER}.srv.com ${SERVER}" >> /etc/hosts
echo "${SERVER}.srv.com" > /etc/hostname

sed -i "s/- set_hostname/#- set_hostname/g" /etc/cloud/cloud.cfg
sed -i "s/- update_hostname/#- update_hostname/g" /etc/cloud/cloud.cfg
sed -i "s/- update_etc_hosts/#- update_etc_hosts/g" /etc/cloud/cloud.cfg

echo "preserve_hostname: true" >>  /etc/cloud/cloud.cfg

echo "HOSTNAME=${SERVER}.srv.com" >> /etc/sysconfig/network

hostnamectl set-hostname ${SERVER}.srv.com --static

###############################
## Attach ephemeral ebs disk ##
###############################

mkdir -p /media/ephemeral0
mkfs.xfs ${EPHEMERALDISK}

UUID=$(blkid | grep "${EPHEMERALDISK}" | cut -d " " -f2|sed 's/"//g')
echo "${UUID} /media/ephemeral0       xfs     defaults        1 1" >> /etc/fstab

mount -a
