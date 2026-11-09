# Architecture and device inventory

**Saved configuration snapshot:** 9 November 2026 (28 nodes, 52 links). This describes the lab design; consult current running configurations for exact interface mappings. DIST2's subsequently added Null0 fallback was reported after the export and is not yet present in its published saved config.

| Zone | Nodes | Purpose |
| --- | --- | --- |
| Amsterdam campus access | AMS-HQ-ACC1, AMS-HQ-ACC2 | VLAN access, trunks and EtherChannels |
| Amsterdam distribution | AMS-HQ-DIST1, AMS-HQ-DIST2 | Layer 3 campus aggregation, HSRP, OSPF |
| Amsterdam WAN edge | AMS-HQ-EDGE1, AMS-HQ-EDGE2 | iBGP/eBGP and WAN connectivity |
| Perimeter | AMS-HQ-FW1, AMS-HQ-FW2, AMS-HQ-PERIM-SW1 | ASA active/standby and security-zone connectivity |
| Rotterdam branch | RTM-BR-R1, RTM-BR-R2, RTM-BR-ACC1 | Branch WAN and switching |
| Simulated providers | ISP-A-R1, ISP-B-R1 | External BGP neighbours |
| Services | DNS/DHCP, TACACS+, syslog, backup, NMS | Infrastructure testing |

## Routing design

- Amsterdam HQ: **AS 65010**
- Rotterdam branch: **AS 65020**
- ISP-A: **AS 65100**
- ISP-B: **AS 65200**
- OSPF process 10: **area 0** at HQ and **area 10** for GRE/branch interfaces (as seen in the saved CML configurations)
- HQ first-hop redundancy: HSRP; branch: VRRP
- WAN experimentation: GRE/IPsec

This document lists intended design roles, not verification that every peering and failover case is currently operational. See [progress](progress.md) and [export inventory](cml-export-inventory.md).
