#!/bin/bash
if openvpn --version &> /dev/null
then
    ps -ef | grep "[o]penvpn" | grep -Eqv "vpn.sh|killall" && (echo "Killing all previous instance of Openvpn" && sudo killall openvpn)
    vpnlist=""
    count=1
    for i in ~/.vpn/*.ovpn ; do
    	f=$(basename -s .ovpn $i)
        vpnlist="$vpnlist $count $f "
        let count=count+1
    done
    result=$(dialog --clear --no-shadow --stdout --menu "OpenVPN Client" 0 0 0 $vpnlist)
    if [ -n "$result" ];then
    	echo "Starting Openvpn ..."
    	screen sudo openvpn --config $(ls ~/.vpn/*.ovpn | head -n $result | tail -n 1)
    	exit 0
    fi
fi
if wg --version &> /dev/null
then
    echo "Stopping all previous instance of Wireguard"
    for RUNNING_WIREGUARD in $(sudo wg show all dump | awk '{print $1}' | sort -u)
    do
        echo "Stopping ${RUNNING_WIREGUARD}"
        sudo wg-quick down "${RUNNING_WIREGUARD}"
    done
    vpnlist=""
    count=1
    for i in ~/.vpn/*.conf ; do
    	f=$(basename -s .conf $i)
        vpnlist="$vpnlist $count $f "
        let count=count+1
    done
    result=$(dialog --clear --no-shadow --stdout --menu "Wireguard Client" 0 0 0 $vpnlist)
    echo $result
    if [ -n "$result" ];then
    	echo "Starting Wireguard ..."
    	screen sudo wg-quick up $(ls ~/.vpn/*.conf | head -n $result | tail -n 1)
    	exit 0
    fi
fi