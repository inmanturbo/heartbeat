#!/bin/bash

echo "Please enter VM name of virtualized nas"
echo "Options listed below"
sudo virsh list --all 
echo ""
read VIRT_NAS
echo ""
echo "Please enter vm name of virtualized storage pool"
echo "Options listed below"
sudo virsh pool-list 
echo ""
read VIRT_NAS_POOL
echo ""
sudo virsh pool-autostart ${VIRT_NAS_POOL} --disable
sudo virsh autostart --disable ${VIRT_NAS}

sudo mkdir -p /usr/local
sudo mkdir -p /etc/systemd/system

sudo cp heartbeat_up.sh /usr/local
sudo cp heartbeat_down.sh /usr/local

sudo cp heartbeat.service /etc/systemd/system

echo "VIRT_NAS=\"$VIRT_NAS\""|sudo tee -a /etc/profile.d/libvirt.sh
echo "VIRT_NAS_POOL=\"${VIRT_NAS_POOL}\""|sudo tee -a /etc/profile.d/libvirt.sh

echo 'ON_BOOT=ignore'| sudo tee -a /etc/sysconfig/libvirt-guests

sudo systemctl enable libvirt-guests.service
sudo systemctl enable heartbeat.service
