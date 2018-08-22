#!/bin/bash
dialog --create-rc /tmp/dialog_rc
export DIALOGRC=/tmp/dialog_rc
echo "Killing all previous instance of Openvpn"
sudo killall openvpn
result=$(dialog --clear --no-shadow --stdout --menu "OpenVnp Client" 0 0 0 "1" "AMS" "2" "FR")
if [ -n "$result" ];then
	echo "Starting Openvpn ..."
	if [ "$result" -eq "1" ];then
		screen sudo openvpn --config .config/openvpn/$(ls .config/openvpn | grep aegis_ams)
	elif [ "$result" -eq "2" ];then
		screen sudo openvpn --config .config/openvpn/$(ls .config/openvpn | grep aegis_fr)
	fi
fi