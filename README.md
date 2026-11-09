# CCNP Enterprise Campus & WAN Lab | Cisco CML

A **work-in-progress enterprise network design** built and tested in Cisco Modeling Labs (CML) Personal. This repository documents the lab as it evolves: its architecture, the technologies practiced, verified observations, and the next experiments.


## Topology overview

The lab models an Amsterdam HQ, Rotterdam branch, two independent ISP autonomous systems, and supporting enterprise services.

![Cisco CML Enterprise Campus and WAN topology](topology/Topology.png)

*Amsterdam HQ, Rotterdam branch, dual ISP connectivity, ASA perimeter, server infrastructure, and test endpoints. Image and archived device configurations have different snapshot dates.*

## Technologies in the lab

| Area | Design / experiments |
| --- | --- |
| Campus switching | VLANs, 802.1Q trunks, LACP EtherChannel |
| First-hop redundancy | HSRP at HQ; VRRP at the branch |
| IGP / edge routing | OSPF area 0, iBGP and eBGP |
| WAN | Dual simulated ISPs and GRE/IPsec experiments |
| Security | ASA active/standby, inside/outside/DMZ, NAT/PAT, ACLs, PBR |
| Infrastructure | DHCP, DNS, syslog, TACACS+, NTP, SNMPv3, NMS and backups |

## Implementation documentation

- [HQ Switching: LACP, STP, HSRP, OSPF, PBR](docs/hq-switching-implementation.md)
- [WAN, BGP, OSPF and Branch](docs/wan-branch-implementation.md)
- [ASA Perimeter and Failover](docs/perimeter-security.md)
- [Infrastructure Services: DHCP, DNS, TACACS+, Syslog, NMS](docs/infrastructure-services.md)
- **[9 November: CCNP LAB DESIGN SUMMARY](docs/ccnp-lab-design-summary-2026-11-09.md)**
- [ASA Stateful TCP Failover](docs/asa-stateful-tcp-failover.md)
- [IP SLA Stage 1.13 / Object Tracking](docs/ip-sla-object-tracking.md)
- **[Updated CML configuration export — 9 November 2026](docs/latest-cml-config-snapshot-2026-11-09.md)**
- [Configuration Source and Fidelity](docs/configuration-source-and-fidelity.md)
- [Configuration Review Findings](docs/review-findings.md)
- [CML Inventory](docs/cml-export-inventory.md) and [Progress / Test Status](docs/progress.md)


## Latest reported checkpoints — 9 November 2026

- **ASA stateful TCP HA:** Existing EDGE1 → DMZ HTTP session was preserved when FW2 became Active; HTTP GET on the original connection returned **200 OK**.
- **DMZ static NAT:** `172.16.70.10` published as `192.0.2.22`, with HTTP on port 8080. HQ/branch PAT uses outside `192.0.2.20`.
- **Five final ASA packet-tracer checks** produced expected allow/deny decisions, including HQ, guest, branch and outside-to-DMZ policies.
- **VLAN10 HSRP failover** DIST1 → DIST2: zero observed ping loss in that test.
- **IP SLA 10 passed** probing `10.255.100.4` (31 successes, zero failures), but **object tracking was not supported** by the IOL-L2 17.18.2 node.
- **Outstanding:** tracked default route, controlled full ISP/edge failures, and real branch-client Internet connectivity.

These are recovered **conversation test results**, not new tests in this GitHub update. See [full dated checkpoint](docs/ccnp-lab-design-summary-2026-11-09.md).

## Published configuration snapshots

| Folder | Contents |
| --- | --- |
| [configs/hq/](configs/hq/) | 6 HQ switches and WAN edge devices |
| [configs/branch/](configs/branch/) | 3 Rotterdam routers / access devices |
| [configs/isp/](configs/isp/) | 2 simulated ISP routers |
| [configs/security/](configs/security/) | 2 ASA firewalls + perimeter switch |
| [configs/services/](configs/services/) | 6 saved service files for 4 service nodes |

**20 files from 18 configured CML nodes** are published from the **9 November 2026 export** (28 total nodes, 52 links). All exported network interface stanzas are preserved. Credentials, authentication material and certificate private contents are redacted, so these are **non-deployable historical snapshots**. Ten other CML endpoints had no saved node configuration files in the export.

**The CML YAML itself is not published.** The [topology screenshot](topology/Topology.png) is the visual reference. FW1's export contains corrected `outside`; FW2's file still shows `outisde`. **DIST2's Null0 fallback was added after the uploaded export**, as reported by the lab owner. See [latest export findings](docs/latest-cml-config-snapshot-2026-11-09.md).

## Workflow for future updates

1. Configure and test a new stage in CML.
2. Record relevant show-command evidence and any observed caveats.
3. Redact passwords, keys, SNMP authentication/privacy secrets, VPN pre-shared keys and tokens before committing configs.
4. Update `docs/progress.md` and `CHANGELOG.md`, then commit to GitHub.

## Environment

Cisco CML Personal **2.10.0+build.13** on a Windows 11 Pro host (32 GB RAM).

## Related standalone practice labs

- [BGP CML Labs](https://github.com/enisalushi/ccnp-bgp-cml-labs)
- [QoS Enterprise / SP Lab](https://github.com/enisalushi/cisco-qos-enterprise-sp-lab)
- [OSPF Multi-Area Lab](https://github.com/enisalushi/ospf-multi-area-lab)

*Educational and self-study use only.*
