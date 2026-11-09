# Verification Evidence Gallery — Screenshot Capture Guide

This folder will hold **real CML CLI screenshots** for the [validated project showcase](../docs/ccnp-lab-design-summary-2026-11-09.md) and a reusable **LinkedIn project carousel**.

**Current assets:** [Actual CML topology](../topology/Topology.png) is already available. Command-output screenshots below are **capture targets**, not uploaded proof. Do not label a protocol as verified until its actual operational output is inspected.

## Recommended screenshots

| Priority | Image / suggested file name | Device and evidence | What the image must prove |
| --- | --- | --- | --- |
| 1 | `security/01-static-nat.png` | ASA FW1: `show nat detail` | Static NAT for DMZ `172.16.70.10` → `192.0.2.22`, with correct interface direction |
| 2 | `security/02-dynamic-xlate.png` | Active ASA: `show xlate` after HQ VLAN10 traffic | Actual dynamic PAT mapping from `10.10.10.138` to outside `192.0.2.20` |
| 3 | `security/03-conn-and-failover.png` | Active ASA before/after: `show conn` and `show failover` | The same established TCP flow is present after FW2 becomes Active; pair with HTTP 200 OK evidence |
| 4 | `routing/04-ospf-full.png` | HQ EDGE1/DIST1: `show ip ospf neighbor` | Correct neighbors reach **FULL** state; record router IDs/interfaces |
| 5 | `routing/05-bgp-established.png` | HQ EDGE1 or EDGE2: `show bgp ipv4 unicast summary` | Expected iBGP/eBGP sessions are **Established**, with received prefixes rather than idle/active state |
| 6 | `vpn/06-isakmp-sa.png` | HQ EDGE1/branch R1: `show crypto isakmp sa` | IKEv1 security association established (commonly `QM_IDLE` for working IKEv1 main-mode peers) |
| 7 | `vpn/07-ipsec-sa.png` | Same tunnel pair: `show crypto ipsec sa` | Nonzero, **increasing encapsulation AND decapsulation counters** during generated GRE traffic |
| 8 | `qos/08-wan-policy.png` | HQ EDGE1 `Ethernet0/2`: `show policy-map interface Ethernet0/2` | 1 Mbps WAN shaper and policy class counters under actual traffic |
| 9 | `qos/09-gre-policy.png` | HQ EDGE1 `Tunnel10`: `show policy-map interface Tunnel10` | Tunnel classes matched and counters increasing when voice/video/critical/guest traffic is generated |
| 10 | `routing/10-traceroute.png` | Client or router: destination-specific `traceroute` | Observed forwarding path for one documented source/destination pair—not standalone proof of IPsec |
| 11 | `redundancy/11-hsrp-before-after.png` | DIST1 and DIST2: `show standby brief` before/after | VLAN 10 HSRP role swap, with separate continuous-ping loss summary |

The exact platform command may vary by image. These are **evidence candidates**; configured policies alone do not show that classification, tunnels or routing adjacencies work.

## Commands for screenshot capture

**ASA — Privileged EXEC mode:**

```cisco
show nat detail
show xlate
show conn
show failover
show access-list
```

**IOS / IOS-XE routers and switches — Privileged EXEC mode:**

```cisco
show ip ospf neighbor
show bgp ipv4 unicast summary
show ip route
show crypto isakmp sa
show crypto ipsec sa
show policy-map interface Ethernet0/2
show policy-map interface Tunnel10
show standby brief
```

**Sample IOS-XE path test — Privileged EXEC mode (replace the destination with the endpoint actually tested):**

```cisco
traceroute 10.20.120.100
```

Do not run interface-specific commands on unrelated devices; `Ethernet0/2` and `Tunnel10` here refer to **HQ EDGE1** in the saved CML export.

## Screenshot quality standards

1. Keep **hostname, command and decisive output** visible. Crop unrelated console history and browser chrome.
2. For each result, capture **source device, destination or peer, expected state and actual state**. When comparing counters, take before/after output under meaningful traffic.
3. Never expose local account passwords, TACACS shared keys, SNMP auth/privacy strings, IKE/IPsec PSKs, certificates, user tokens or real organization identifiers.
4. Use consistent naming and crisp 16:9 crops when feasible. Avoid overcrowding; combine closely related screenshots into a labeled comparison if necessary.
5. Show real output only. Do not replace the command's state or packet counters with synthetic values.

## LinkedIn carousel recommendation

Make one **7–9 slide technical story**, with a simple structure:

| Slide | Visual | Professional takeaway |
| --- | --- | --- |
| 1 | [CML topology](../topology/Topology.png) | Scope: HQ, branch, dual ISPs, ASA HA |
| 2 | OSPF FULL + BGP Established (after proof collected) | Control-plane connectivity and route exchange |
| 3 | IKEv1 / IPsec states and counters (after proof collected) | Encrypted branch transport with real packet movement |
| 4 | Traceroute (after proof collected) | Demonstrated forwarding path |
| 5 | QoS shaping and class counters (after proof collected) | Classification and treatment under load |
| 6 | ASA NAT / xlate | Address translation demonstrated with a real flow |
| 7 | ASA conn + FW1→FW2 stateful failover + HTTP 200 | Established-session continuity |
| 8 | HSRP before/after | Gateway redundancy and observed loss result |
| 9 | Concise architecture takeaways and GitHub link | Traceable, reproducible lab evidence |

**Selection rule:** Publish only slides with genuine screenshots that confirm the claim. It is better to have **five proven slides than nine screenshots of merely configured features**.

## Linking screenshots into the project

Once the screenshots exist, upload them under the paths above. This folder's README can then display them inline, with one **Objective → Command → Observed result → Network significance** caption for each. The completed project summary should link only to validated screenshot sections, not to empty placeholders.
