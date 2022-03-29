#!/bin/bash

set -o nounset
set -o errexit

case "${PLUTO_VERB}" in
    up-client)
                insmod /opt/lib/modules/ip_vti.ko
                ip tunnel add ipsec0 local "${PLUTO_ME}" remote "${PLUTO_PEER}" mode vti key 42
                ip addr add ${PLUTO_MY_SOURCEIP} dev ipsec0
                ip link set ipsec0 up
		ifconfig ipsec0 mtu 1380
                ip route add $(ip route get "${PLUTO_PEER}" | sed '/ via [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/{s/^\(.* via [0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\).*/\1/}' | head -n 1) 2>/dev/null
                ip route add 0/1 dev ipsec0  proto kernel  scope link src ${PLUTO_MY_SOURCEIP}
                ip route add 128/1 dev ipsec0  proto kernel  scope link src ${PLUTO_MY_SOURCEIP} 
                iptables -t mangle -I FORWARD -o ipsec0 -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
                iptables -t mangle -I FORWARD -i ipsec0 -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
                iptables -t mangle -I FORWARD -o ipsec0 -j MARK --set-xmark 0x01/0x7
                iptables -t mangle -I PREROUTING -i ipsec0 -j MARK --set-xmark 0x01/0x7
                iptables -t nat -I POSTROUTING -s $(nvram get lan_ipaddr)/24 -o ipsec0 -j MASQUERADE
                echo 1 > /proc/sys/net/ipv4/conf/ipsec0/disable_policy
        ;;
    down-client)
                ip route del 0/1 dev ipsec0
                ip route del 128/1 dev ipsec0
                ip route del "${PLUTO_PEER}"
		iptables -t nat -D POSTROUTING -s $(nvram get lan_ipaddr)/24 -o ipsec0 -j MASQUERADE 2>/dev/null
                iptables -t mangle -D PREROUTING -i ipsec0 -j MARK --set-xmark 0x01/0x7 2>/dev/null
                iptables -t mangle -D FORWARD -o ipsec0 -j MARK --set-xmark 0x01/0x7 2>/dev/null
                iptables -t mangle -D FORWARD -i ipsec0 -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu 2>/dev/null
                iptables -t mangle -D FORWARD -o ipsec0 -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu 2>/dev/null
                rmmod ip_vti
        ;;
esac

