# CCNP Enterprise Campus  Verified CLI Evidence

**29 real Cisco CML screenshots**, organized by technical area. Each folder includes the original images and captions explaining **command, observed output and what the result proves**.

![Current enterprise lab topology](../topology/Topology.png)

## Evidence library

| Area | Screenshots | Verified content |
| --- | ---: | --- |
| [Campus switching & redundancy](campus/) | 3 | ACC1 LACP Po11/Po12, HQ HSRP roles, branch VRRP Master state |
| [Routing & forwarding](routing/) | 11 | OSPF FULL, BGP Established, ISP IP SLA/track, installed routes, branch-to-HQ traceroute |
| [GRE / IKE / IPsec](vpn/) | 3 | IKEv1 QM_IDLE and nonzero ESP encapsulation/decapsulation on both branch VPN paths |
| [QoS](qos/) | 3 | 1 Mbps WAN shaper attachment and counters; tunnel priority classes with **zero matching packets** |
| [ASA security & NAT](security/) | 6 | ASA Active/Standby Ready, NAT, live PAT xlate, ACL hit counts, HTTP 200 OK, ICMP conn |
| [Enterprise services](services/) | 3 | EDGE1 NTP synchronized; branch-to-HQ SSH login; accepted TACACS+ EXEC authorization |


## Evidence rules

- These are original user-supplied console screenshots, **not generated output**.
- A configured policy is distinct from actual matching traffic or validated failure recovery.
- `show conn` in the currently published security gallery records **ICMP**, not the original established **TCP session** used in the prior ASA stateful failover experiment.
- VPN nonzero SA counters prove earlier protected traffic, **not a measured before/after delta**.
- No YAML, authentication secrets, private certificates or operational passwords are published.

[Command collection guide for future tests](capture-guide.md) · [Validated project showcase](../docs/ccnp-lab-design-summary-2026-11-09.md)
