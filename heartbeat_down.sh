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

### Restore Vms: ####

# Get all running vms
for VM in $(virsh list --name) 
do
  # Attempt to Save them
   if [[ ! "$VM" == "${1}" ]] ; then
  virsh managed-save "$VM"
  fi
done

virsh list > /root/saved-vms.txt;
virsh list;

# Get all running vms
for VM in $(virsh list --name) 
do
  # Attempt to shutdown those which could not be saved
   if [[ ! "$VM" == "${1}" ]] ; then
  virsh shutdown "$VM"
  fi
done

virsh list > /root/scripts/shutdown-vms.txt;
virsh list;

# Get all running vms
for VM in $(virsh list --name) 
do
  # Kill the ones that possibly hung
  # remember the important thing
  # is to free up the zfs pool
   if [[ ! "$VM" == "${1}" ]] ; then
  virsh destroy "$VM"
  fi
done

virsh list > /root/killed-vms.txt;
virsh list;


virsh pool-destroy ${2}
virsh shutdown ${1}

exit 0;



