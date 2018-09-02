#!/bin/bash
echo "Killing all previous instance of Openvpn"
sudo killall openvpn
vpnlist=""
count=1
for i in ~/.vpn/* ; do
	f=$(basename -s .ovpn $i)
    vpnlist="$vpnlist $count $f "
    let count=count+1
done
result=$(dialog --clear --no-shadow --stdout --menu "OpenV'np Client" 0 0 0 $vpnlist)
if [ -n "$result" ];then
	echo "Starting Openvpn ..."
	screen sudo openvpn --config ~/.vpn/$(ls ~/.vpn | head -n $result | tail -n 1)
fi