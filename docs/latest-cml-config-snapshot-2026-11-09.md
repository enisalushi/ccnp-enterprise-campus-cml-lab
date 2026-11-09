# Updated CML configuration export — 9 November 2026

**Source:** User-supplied Cisco CML YAML uploaded on 9 November 2026. The original YAML and annotations remain private; this public repository contains only sanitized saved-node configurations.

## Inventory

| | 2 November export | 9 November export |
| --- | ---: | ---: |
| Nodes | 28 | **28** |
| Links | 51 | **52** |
| Configured nodes | 18 | **18** |
| Saved configuration files | 20 | **20** |

All 20 files under [configs/](../configs/) have been refreshed from the newer export. They include **all saved interface stanzas**, routing, ACLs, QoS, PBR, NAT, management and other non-sensitive configuration. Passwords, key material, user hashes and certificate chains are omitted; the published configs are not deployable backups.

## Key changes captured in the new export

- **HQ EDGE1 and EDGE2:** ISP-side `ip sla 10` / `ip sla 20`, `track 10` / `track 20`, and tracked ISP default routes. These are **edge-router** track objects, distinct from the earlier unsupported object-tracking command on a distribution IOL-L2 node.
- **WAN and GRE QoS:** 1 Mbps WAN shaping, DSCP marking (EF, AF41, AF31 and CS1), and class-based tunnel policing.
- **Rotterdam BR-R1 and BR-R2:** `PBR-BRANCH-INTERNET-HQ` applied to VLAN 110–160 subinterfaces, steering matched Internet-bound traffic over the GRE paths while excluding internal/reserved destinations.
- **HQ EDGE1 and EDGE2:** `PBR-BRANCH-TO-DIST` attached to Tunnel10 / Tunnel20.
- **HQ DIST1:** primary default through ASA inside `10.255.100.4` with a floating `Null0` fallback in its 9 November saved configuration.
- **ASA FW1:** corrected interface name `outside` and newer NAT/ACL policy configuration.

## Saved-export findings and updates afterward

| Device | 9 November saved configuration | Most recent report |
| --- | --- | --- |
| DIST1 | ASA default and Null0 fallback | Both appear in export |
| DIST2 | ASA default only; Null0 not present in the uploaded YAML | **Lab owner has since added Null0 on DIST2**; requires a fresh export to record exact command and administrative distance |
| ASA FW1 | `nameif outside` | Corrected in export |
| ASA FW2 | `nameif outisde` | Still present in exported saved configuration; verify HA synchronization and interface naming |
| DIST1/DIST2 | The former VLAN 10 SVI PBR attachment is absent | Confirm whether the newer routing design intentionally removed it |

**The GitHub `configs/hq/AMS-HQ-DIST2.cfg` file is preserved faithfully from the uploaded YAML.** We did not insert an unverified `ip route ... Null0` line. Your newer DIST2 change is documented here as a **post-export configuration update**.

The CML topology has a multicast troubleshooting note: TX1 packets reached its ACC1-facing link, but the expected `(S,G)` state was not established on DIST1/DIST2. Saved PIM configuration does not prove multicast forwarding is working.

## Verification status

This export demonstrates **configured features**, not runtime status. See [9 November lab discussion checkpoint](ccnp-lab-design-summary-2026-11-09.md) for previously reported ASA/HSRP/IP SLA test results. Validate the newer configurations with current routing, HA, BGP/OSPF, IPsec, QoS and multicast show-command evidence.

[Back to README](../README.md)
