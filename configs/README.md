# Saved device and service configurations

**Source:** Original Cisco CML node configuration entries from export, 2026-11-02. See [configuration source and fidelity audit](../docs/configuration-source-and-fidelity.md) for original filenames and preservation details. The 20 files below are complete substantive **sanitized configuration snapshots** from the exported node files. All network-device interface stanzas are retained. Secrets and certificates are removed; these are **not deployable backups**.

| Folder | Exported files | Notes |
| --- | ---: | --- |
| [HQ campus & edge](hq/) | 6 | ACC1, ACC2, DIST1, DIST2, EDGE1, EDGE2 |
| [Branch](branch/) | 3 | RTM-BR-ACC1, RTM-BR-R1, RTM-BR-R2 |
| [ISP simulation](isp/) | 2 | ISP-A-R1, ISP-B-R1 |
| [Perimeter](security/) | 3 | FW1, FW2, perimeter switch |
| [Infrastructure services](services/) | 6 | DHCP/DNS (2), syslog (1), TACACS+ (2), NMS (1) |

The service-node total is 6 files for 4 nodes, giving 20 config files across 18 configured nodes. The other 10 CML nodes are endpoints without saved configuration files.

Read [HQ implementation](../docs/hq-switching-implementation.md), [WAN/branch](../docs/wan-branch-implementation.md), [ASA perimeter](../docs/perimeter-security.md), [services](../docs/infrastructure-services.md), and [known issues](../docs/review-findings.md).

## Confidentiality

Removed before publication: local account passwords/hashes, TACACS+ shared secrets and user passwords, SNMPv3 auth/privacy credentials, OSPF/BGP authentication passwords, IKE PSKs, ASA failover secrets and private certificate contents. A blank/redacted value is not a usable device command.

Never upload the original CML export or raw device configs to the public repo. The `.gitignore` is not a substitute for manual secret review.
