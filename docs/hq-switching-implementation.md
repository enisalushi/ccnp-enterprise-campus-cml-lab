# Stage 1 — HQ campus switching and routing

**Source:** Saved Cisco CML configuration export from 2 November 2026 (not live operational outputs).

This stage provides **full substantive sanitized configurations from the saved 2 November 2026 CML export**. All exported interface stanzas, including unused ports, are included (ACC1 19, ACC2 19, DIST1 36, DIST2 32). Credential-bearing lines are redacted; the complete original interface stanzas are preserved, so the files are **not deployable backups**.

## Sanitized full device snapshots

| Device | Role | Snapshot |
| --- | --- | --- |
| AMS-HQ-ACC1 | HQ access switch | [ACC1](../configs/hq/AMS-HQ-ACC1.cfg) |
| AMS-HQ-ACC2 | HQ access switch | [ACC2](../configs/hq/AMS-HQ-ACC2.cfg) |
| AMS-HQ-DIST1 | HQ distribution, OSPF, HSRP, PBR | [DIST1](../configs/hq/AMS-HQ-DIST1.cfg) |
| AMS-HQ-DIST2 | HQ distribution, OSPF, HSRP | [DIST2](../configs/hq/AMS-HQ-DIST2.cfg) |

## L2 design

- Rapid PVST+ runs across the campus.
- ACC1 uses LACP **Po11** to DIST1 and **Po12** to DIST2.
- ACC2 uses LACP **Po21** to DIST1 and **Po22** to DIST2.
- DIST1 and DIST2 interconnect using **Po10**.
- VLAN 999 is the trunk native VLAN.
- Access assignments include users (VLAN 10), voice (20), video (30), critical (40), management (50), and guest (60).
- Configured access-port BPDU Guard / PortFast settings and DHCP-snooping trust are visible in archived configs; globally enforced DHCP snooping requires separate verification.

### STP root preference

| VLANs | DIST1 priority | DIST2 priority | Preferred lower priority |
| --- | ---: | ---: | --- |
| 10, 30, 50, 70, 80, 999 | 24576 | 28672 | DIST1 |
| 20, 40, 60 | 28672 | 24576 | DIST2 |

The lower configured bridge priority wins the root election **assuming no other bridge has a superior BID**.

## L3 and HSRP

DIST1 and DIST2 host the HQ SVIs and share HSRP virtual gateways. **HSRP version 2** is configured.

| VLAN | VIP | DIST1 SVI | DIST2 SVI | Higher HSRP priority |
| --- | --- | --- | --- | --- |
| 10 | 10.10.10.1 | 10.10.10.2 | 10.10.10.3 | DIST1 |
| 20 | 10.10.20.1 | 10.10.20.2 | 10.10.20.3 | DIST2 |
| 30 | 10.10.30.1 | 10.10.30.2 | 10.10.30.3 | DIST1 |
| 40 | 10.10.40.1 | 10.10.40.2 | 10.10.40.3 | DIST2 |
| 50 | 10.10.50.1 | 10.10.50.2 | 10.10.50.3 | DIST1 |
| 60 | 10.10.60.1 | 10.10.60.2 | 10.10.60.3 | DIST2 |
| 70 | 10.10.70.1 | 10.10.70.2 | 10.10.70.3 | DIST1 |
| 80 (firewall transit) | 10.255.100.1 | 10.255.100.2 | 10.255.100.3 | DIST1 |

OSPF **process 10 / area 0** uses explicit router IDs and `passive-interface default`. Routed uplinks to HQ EDGE1/EDGE2 are non-passive and have message-digest authentication configured. The authentication keys were removed from the published sanitized configs.

## Important follow-up checks from the saved export

1. **PBR ACL reference:** DIST1's route-map matches `ACL-VLAN10-ASA-TEST`, but its defined extended ACL is `ACL-VLAN-10-ASA-TEST`. The mismatch means the intended ACL-based match should **not be assumed functional** from this export. Check the current config before changing or claiming behavior.
2. **PBR resilience:** The saved export applies `PBR-VLAN10-ASA` to DIST1's VLAN 10 SVI, while DIST2 has no matching policy. Test the path after HSRP failover.
3. **Trunk allowed VLANs:** ACC2's Po21/Po22 permit VLAN 998 but not 70, whereas their DIST-side Po21/Po22 permit VLAN 70 but not 998. Confirm whether this asymmetry is intentional.
4. **DHCP snooping:** Trusted uplinks are configured, but verify whether snooping is enabled globally and per VLAN in the running switch configuration.
5. **OSPF authentication:** Message-digest authentication requires matching keys on both ends. The publicly shared files intentionally omit them.

## Validation commands

**Switches and routers — Privileged EXEC mode:**

```cisco
show etherchannel summary
show interfaces trunk
show spanning-tree root
show standby brief
show ip ospf neighbor
show ip route ospf
show route-map PBR-VLAN10-ASA
show ip access-lists
show ip dhcp snooping
```

These are next-step verification commands; outputs have **not** been attached to this snapshot.

[Back to README](../README.md)
