# Configuration review findings

Snapshot audited: **2026-11-02 CML export**. These are configuration observations, **not live failures**. No changes were pushed to CML devices.

| Item | Observation | Suggested verification |
| --- | --- | --- |
| DIST1 PBR ACL | Route-map refers to `ACL-VLAN10-ASA-TEST` but defined ACL is `ACL-VLAN-10-ASA-TEST` | `show route-map`, `show ip access-lists`, `show ip policy`; correct mismatch if still present |
| PBR failover | VLAN 10 PBR is on DIST1 SVI, not matching DIST2 SVI in archived export | Test forwarding during HSRP active transition |
| ACC2 trunk VLANs | Po21/Po22 on ACC2 allow 998, not 70; DIST interfaces allow 70, not 998 | Verify allowed/active VLANs and intended parking/service VLANs |
| ASA nameif | Archive uses `outisde` across ASA interface/NAT/route/MTU; owner reports later correction to `outside` | Verify updated running-config on both units |
| ASA ACL state | Prior intentional ICMP denial was observed after a successful PAT connectivity test | Run fresh policy review and packet-tracer to document current behavior |
| TACACS+ | Published config deliberately excludes users/keys | Use private, working secrets for actual lab deployment; verify AAA |
| DNS/DHCP boot | Archived script uses world-writable `chmod 777 /var/ftpd` | Restrict permissions outside isolated lab |
| Operational status | Saved CML configs do not prove BGP/OSPF neighbours, IPsec SAs, HA convergence or application success | Attach dated `show` outputs and end-to-end tests |

## Baseline evidence still required

**Cisco IOS/IOS-XE — Privileged EXEC mode:**

```cisco
show etherchannel summary
show interfaces trunk
show standby brief
show vrrp brief
show ip ospf neighbor
show bgp ipv4 unicast summary
show ip route
show track
```

**Cisco ASA — Privileged EXEC mode:**

```cisco
show failover
show route
show nat detail
show access-list
```

Sensitive AAA, IKE, SNMP and certificate contents have been removed before public publication. These redactions mean configurations are **not suitable as backups**.

[Back to overview](../README.md)
