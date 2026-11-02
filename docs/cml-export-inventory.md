# Cisco CML export inventory — 2 November 2026

This page records the **device and configuration inventory** from the user's CML export, not live runtime verification. The CML YAML itself is intentionally excluded from the public repository.

## Snapshot facts

| Item | Count |
| --- | ---: |
| Total CML nodes | 28 |
| CML links | 51 |
| Nodes with saved configuration files | 18 |
| Saved configuration file entries | 20 |
| Nodes without saved configuration files | 10 |

## Network devices

| Group | Exported nodes |
| --- | --- |
| HQ WAN edge | `AMS-HQ-EDGE1`, `AMS-HQ-EDGE2` |
| HQ distribution | `AMS-HQ-DIST1`, `AMS-HQ-DIST2` |
| HQ access | `AMS-HQ-ACC1`, `AMS-HQ-ACC2` |
| Branch | `RTM-BR-R1`, `RTM-BR-R2`, `RTM-BR-ACC1` |
| Simulated ISP | `ISP-A-R1`, `ISP-B-R1` |
| Perimeter security | `AMS-HQ-FW1`, `AMS-HQ-FW2`, `AMS-HQ-PERIM-SW1` |

## Infrastructure service nodes

- `AMS-HQ-DNS-DHCP1`: `dnsmasq.conf` and `boot.sh`
- `AMS-HQ-SYSLOG1`: `boot.sh`
- `AMS-HQ-TACACS1`: `tac_plus.conf` and `boot.sh`
- `AMS-HQ-NMS1`: `boot.sh`

The remaining 10 nodes are endpoints and supporting containers that did not have saved node configuration files in this export.

## Configuration evidence

The saved configurations contain these *configured* features. A configured feature is not proof of an operational state.

| Feature | Where seen |
| --- | --- |
| eBGP / iBGP | ISP, HQ edge and branch routers |
| OSPF process 10 | HQ edge/distribution and branch routers |
| OSPF area 0 | HQ internal links |
| OSPF area 10 | Tunnel and branch LAN routing interfaces |
| HSRP | HQ distribution switches and HQ WAN edge |
| VRRP | Branch routers, VLANs 110–160 |
| LACP EtherChannel | HQ distribution and access switches |
| PBR | `AMS-HQ-DIST1`, route-map `PBR-VLAN10-ASA` |
| GRE / IKEv1 / IPsec | HQ edge and branch routers |
| ASA failover links | `AMS-HQ-FW1` and `AMS-HQ-FW2` |
| ASA inside PAT | `AMS-HQ-FW1` exported configuration |
| TACACS+ / SNMP | Several routers and switches |

### Notes before publishing full configurations

- The ASA outside security interface is named **`outisde`** (sic) in the exported configurations. Cisco ASA treats this as a literal `nameif`; future packet-tracer/NAT/ACL commands must use the configured spelling until it is corrected consistently.
- The VLAN 10 PBR route-map is present on **DIST1** in this export. Verify HSRP failover behavior before describing the forwarding policy as redundant on both distribution switches.
- Raw saved configurations include credential/hash material, SNMPv3 authentication data, TACACS keys, IKE pre-shared keys, and certificate material. **Do not upload the original YAML or raw config files into this public repository.**
- Redacted snapshots omit credential and PKI commands, so they are documentation, **not deployable backups**.

## Next publication milestones

1. Publish individually reviewed, sanitized HQ access and distribution configuration snapshots.
2. Attach real `show etherchannel summary`, `show standby brief`, and `show ip ospf neighbor` verification results.
3. Publish edge/branch BGP and GRE/IPsec configuration snapshots with PSKs and authentication fields removed.
4. Publish sanitized ASA configurations and verify intended ACL, NAT and active/standby failover behavior.
5. Add infrastructure service setups with shared credentials removed.

[Back to project overview](../README.md)
