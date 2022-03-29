#!/bin/bash

set -o nounset
set -o errexit

case "${PLUTO_VERB}" in
    up-client)
                iptables -t mangle -I POSTROUTING -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1280
                iptables -t nat -I POSTROUTING -o eth0 ! -p esp -j SNAT --to-source ${PLUTO_MY_SOURCEIP}
                if [ "$(cat /etc/resolv.conf | grep strongSwan)" != "" ] && [ ! -f /tmp/resolv.dnsmasq_backup ]; then {
                        cp /tmp/resolv.dnsmasq /tmp/resolv.dnsmasq_backup
                        cp /tmp/resolv.conf /tmp/resolv.conf_backup
                        cat /etc/resolv.conf | grep strongSwan | sed "s|nameserver\ |server=|g" > /tmp/resolv.dnsmasq
                        service restart_dnsmasq;sleep 2 2>/dev/null
                        cat /tmp/resolv.dnsmasq | grep strongSwan | sed "s|server=|nameserver\ |g" > /etc/resolv.conf
                        }
                fi
        ;;
    down-client)
                iptables -t nat -D POSTROUTING -o eth0 ! -p esp -j SNAT --to-source ${PLUTO_MY_SOURCEIP} 2>/dev/null
                iptables -t mangle -D POSTROUTING -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --set-mss 1280 2>/dev/null
                if [ -f /tmp/resolv.dnsmasq_backup ]; then {
                        mv /tmp/resolv.dnsmasq_backup /tmp/resolv.dnsmasq 2>/dev/null
                        mv /tmp/resolv.conf_backup /tmp/resolv.conf 2>/dev/null
                        }
                fi
                service restart_dnsmasq 2>/dev/null
        ;;
esac
