#!/bin/sh

if [ -z "$1" ] ;
then
 echo Specify a virtual-machine name.
 exit 1
fi

if [ -z "$2" ] ;
then
 echo Specify a storage pool.
 exit 1
fi

virsh start ${1} || { echo 'Host did not start. Check logs' ; exit 1; }

until virsh pool-start ${2}
do
  echo "Storage host not ready"
done

### Restore Vms: ####

# Get all saved vms
for VM in $(virsh list --all --with-managed-save --name) 
do
  # Restore them
  virsh restore "$VM"
done

virsh list > /root/restored-vms.txt;
virsh list;

### Start Vms: ####

# Get all vms marked for autostart which are not allready running
for VM in $(virsh list --autostart --inactive --name) 
do
  # Start them
  virsh start "$VM"
done

virsh list > /root/started-vms.txt;
virsh list;

exit 0;
