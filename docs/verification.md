# CLI Verification and Evidence Capture

Use these commands to capture **real lab proof** for the [portfolio showcase](ccnp-lab-design-summary-2026-11-09.md). See [screenshot gallery guide](../evidence/README.md) for exact intended proof and images.

**Cisco IOS/IOS-XE — Privileged EXEC mode:**

```cisco
show ip interface brief
show interfaces trunk
show etherchannel summary
show standby brief
show vrrp brief
show ip ospf neighbor
show bgp ipv4 unicast summary
show ip route
show crypto isakmp sa
show crypto ipsec sa
```

**HQ EDGE1 — Privileged EXEC mode, QoS-specific interfaces:**

```cisco
show policy-map interface Ethernet0/2
show policy-map interface Tunnel10
```

**Cisco ASA — Privileged EXEC mode:**

```cisco
show failover
show interface ip brief
show route
show nat detail
show xlate
show conn
show access-group
show access-list
```

The **five final ASA packet-tracer cases** in the [validated summary](ccnp-lab-design-summary-2026-11-09.md) produced their expected decisions. An earlier intentionally denied ICMP case was a negative policy test, not evidence that all later traffic was denied.

Capture packet/counter changes under generated traffic. IKEv1 phase state without increasing IPsec encrypt/decrypt counters does not, by itself, prove encrypted forwarding; likewise configured QoS policy without matched packet counters does not prove classification.

Never post login secrets, SNMP authentication data, PSKs, private key material, or other confidential data in screenshots.
