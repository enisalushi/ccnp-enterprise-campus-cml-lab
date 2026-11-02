# Verification checklist

Capture outputs with the device hostname, date, intended result and actual result.

## Cisco IOS / IOS-XE — Privileged EXEC

```cisco
show ip interface brief
show interfaces trunk
show etherchannel summary
show standby brief
show vrrp brief
show ip ospf neighbor
show bgp ipv4 unicast summary
show ip route
```

## Cisco ASA — Privileged EXEC

```cisco
show failover
show interface ip brief
show route
show access-group
show access-list
show nat detail
show xlate
show logging
packet-tracer input inside icmp 10.10.10.138 8 0 8.8.8.8 detailed
```

The latest documented packet-tracer result was **DROP due to the intentional inside ACL test**. Do not interpret this as a routing failure.

Some commands vary by CML node image and software version.
