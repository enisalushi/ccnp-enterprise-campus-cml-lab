ip link set dev eth0 up
ip address flush dev eth0
ip address add 10.10.70.60/24 dev eth0
ip route replace default via 10.10.70.1 dev eth0

echo "===== TACACS NETWORK =====" >/dev/console
ip address show dev eth0 >/dev/console 2>&1
ip route >/dev/console 2>&1

echo "===== GATEWAY TEST =====" >/dev/console
ping -c 3 -W 1 10.10.70.1 >/dev/console 2>&1

echo "READY" >/dev/console
exit 0