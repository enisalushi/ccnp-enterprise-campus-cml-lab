# CCNP Enterprise Campus & WAN Lab | Cisco CML

A **work-in-progress enterprise network design** built and tested in Cisco Modeling Labs (CML) Personal. This repository documents the lab as it evolves: its architecture, the technologies practiced, verified observations, and the next experiments.

**Latest documentation snapshot:** 2 November 2026. This is a learning lab, not a production design or a claim that every feature is fully tested.

## Topology overview

The lab models an Amsterdam HQ, Rotterdam branch, two independent ISP autonomous systems, and supporting enterprise services.

![Cisco CML Enterprise Campus and WAN topology](topology/Topology.png)

*Current Cisco CML topology screenshot — Amsterdam HQ, Rotterdam branch, two ISP autonomous systems, firewall pair, and supporting services. Interface and link details should be verified against the current CML lab.*

## Technologies in the lab

| Area | Design / experiments |
| --- | --- |
| Campus switching | VLANs, 802.1Q trunks, LACP EtherChannel |
| First-hop redundancy | HSRP at HQ; VRRP at the branch |
| IGP / edge routing | OSPF area 0, iBGP and eBGP |
| WAN | Dual simulated ISPs and GRE/IPsec experiments |
| Security | ASA active/standby, inside/outside/DMZ, NAT/PAT, ACLs, PBR |
| Infrastructure | DHCP, DNS, syslog, TACACS+, NTP, SNMPv3, NMS and backups |

See [architecture](docs/architecture.md), [progress / test status](docs/progress.md), and [ASA packet-flow test](docs/asa-traffic-flow.md).

## Current verified checkpoints

- ASA failover status observed as **AMS-HQ-FW1 Active / AMS-HQ-FW2 Standby Ready**.
- A prior VLAN 10 test client (`10.10.10.138`) reached `8.8.8.8` through ASA PAT, translated to `192.0.2.20`.
- A **later, intentionally restrictive ASA ACL test** denied that ICMP flow; `packet-tracer` returned the expected DROP at the access-list phase. This is not proof that Internet access is currently passing.

Other features are documented as lab design/exercises until their latest running state and verification are captured. See [progress](docs/progress.md) for outstanding testing.

## Repository layout

```text
README.md
CHANGELOG.md
docs/
  architecture.md
  addressing.md
  progress.md
  asa-traffic-flow.md
  verification.md
configs/
  README.md
topology/
  README.md
  Topology.png
```

**No CML YAML export is published.** The intention is to share documentation and topology diagrams/screenshots, then add **sanitized device configurations and verification outputs** as individual milestones are completed. This keeps the repository readable without distributing a complete runnable lab file.

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
