#!/bin/bash

# For CentOS 7 AMI, by Amazon

sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sed -i 's/no-port-forwarding.*sleep 10" //g' /root/.ssh/authorized_keys

# Copy key Luis Acosta
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJnN+nLrEtw5FH/jZ4dxNY9w1lD9E0oRrkOz3aTkTmXoiuIQjRTWGoHqTCjW/gIkmEauhQ5bgz48434wmXwBXuFFCeI40FRr1tuOYA+68xeUJyx/Ct4IJT9wmIf+Y2+zJL8Yi/8t0BzFcDmj9sFnBrqGAIfNItJ+du3gVVw7vQ8Pw9HKtzbiprTWn6AjsOkzgbl84arNmomcGlmYHIoSyt0i/IKaBnw+HV3dErsDJCTB7eaFtDKcR351Ps9FObBG32BQyu7sFQttAhGW1Y1ctDz7CP6Y5UCwiVQ6CYChtFEfUB6L7fWuUBlbXZocqG0LExLVFTC3GbDDg28OHw7KC/1iFiqCPGmjE13Oqw4xDwQl8RvYoGG9ESO0XKHE92JashVi1nhHtLA6OKcgqHa51wwN7bK/evOoRG0MgnQr1ex7AXlXT5r+JS7MdbmroVHO61WqZMppR4N7KhKXE7udAapXr466GQI06r0Zep2POMSibVn1dbxQVth5ni5b5Dk7U= langel.acosta@ubuntudesktop" >> /root/.ssh/authorized_keys

sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

echo "127.0.0.1       ${SERVER}.srv.company.com ${SERVER}" >> /etc/hosts
echo "${SERVER}.srv.company.com" > /etc/hostname

sed -i "s/- set_hostname/#- set_hostname/g" /etc/cloud/cloud.cfg
sed -i "s/- update_hostname/#- update_hostname/g" /etc/cloud/cloud.cfg
sed -i "s/- update_etc_hosts/#- update_etc_hosts/g" /etc/cloud/cloud.cfg

echo "preserve_hostname: true" >>  /etc/cloud/cloud.cfg

echo "HOSTNAME=${SERVER}.srv.company.com" >> /etc/sysconfig/network

hostnamectl set-hostname ${SERVER}.srv.company.com --static

###############################
## Attach ephemeral ebs disk ##
###############################

mkdir -p /media/ephemeral0
sudo lsblk | grep -w "5G" | cut -d " " -f1 > /tmp/EPHEMERALDISK
mkfs.xfs /dev/$(cat /tmp/EPHEMERALDISK)
blkid | grep $(cat /tmp/EPHEMERALDISK) | cut -d " " -f2 | sed 's/"//g' > /tmp/UUID
echo "$(cat /tmp/UUID) /media/ephemeral0       xfs     defaults        1 1" >> /etc/fstab

mount -a

##################################
## Install and configure Puppet ##
##################################

sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm && \
yum install -y puppet

echo "    environment = production" >> /etc/puppet/puppet.conf
echo "    server=vs01puppet01.srv.company.com" >> /etc/puppet/puppet.conf

yum update -y
