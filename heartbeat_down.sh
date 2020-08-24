#!/bin/env bash
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

# virsh start ${1} || { echo 'Host did not start. Check logs' ; exit 1; }

# until virsh pool-start ${2}
# do
#   echo "Storage host not ready"
# done

### Restore Vms: ####

# Get all running vms not allready running
for VM in $(virsh list --name) 
do
  # Attempt to Save them
   if [[ ! "$VM" == "${1}" ]] ; then
  virsh managed-save "$VM"
  fi
done

virsh list > /root/scripts/saved-vms.txt;
virsh list;

# Get all running vms not allready running
for VM in $(virsh list --name) 
do
  # Attempt to Save them
   if [[ ! "$VM" == "${1}" ]] ; then
  virsh destroy "$VM"
  fi
done

virsh list > /root/scripts/killed-vms.txt;
virsh list;


virsh pool-destroy ${2}
virsh destroy ${1}
# do
#   echo "Storage host not ready"
# done

exit 0;
# /usr/local/emhttp/webGui/scripts/notify -i normal -s "Veeam done - VMs started"



#until $(ping 192.168.254.254); do :; done
# until $(virsh pool-start QWPro); do echo "host not up" :; done
#virsh pool-start QWPro

# cancelled=false    # Keep track of whether the loop was cancelled, or succeeded
# until ping -c1 "$1" >/dev/null 2>&1; do :; done &    # The "&" backgrounds it
# trap "kill $!; ping_cancelled=true" SIGINT
# wait $!          # Wait for the loop to exit, one way or another
# trap - SIGINT    # Remove the trap, now we're done with it
# echo "Done pinging, cancelled=$cancelled"

# virsh pool-start QWPro
# #sleep 60;
# #virsh start centos8;
