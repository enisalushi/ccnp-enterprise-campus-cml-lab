# Sanitized saved CML startup script (2026-11-02). Test-lab only.
ip link set dev eth0 up
ip address flush dev eth0
ip address add 10.10.70.10/24 dev eth0
ip route replace default via 10.10.70.1 dev eth0

echo "===== ETH0 =====" >/dev/console
ip address show dev eth0 >/dev/console 2>&1

echo "===== ROUTES =====" >/dev/console
ip route >/dev/console 2>&1

echo "===== GATEWAY TEST =====" >/dev/console
ping -c 3 -W 1 10.10.70.1 >/dev/console 2>&1

mkdir -p /var/ftpd
chmod 777 /var/ftpd

echo "READY" >/dev/console
exit 0