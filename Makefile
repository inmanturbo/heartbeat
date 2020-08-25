

install:
	./install.sh

remove:
	sudo rm -f /usr/local/heartbeat_up.sh
	sudo rm -f /usr/local/heartbeat_down.sh
	sudo systemctl disable heartbeat.service
	sudo rm -f /etc/systemd/system/heartbeat.service
	sed -e '/VIRT_NAS/ s/^#*/#/g' -i /etc/profile.d/libvirt.sh
	sed -e '/VIRT_NAS_POOL/ s/^#*/#/g' -i /etc/profile.d/libvirt.sh
	