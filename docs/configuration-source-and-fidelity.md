# Configuration source and fidelity

The published configuration files are derived from the **original saved node configuration entries in the Cisco CML export dated 2 November 2026**. The newer [topology screenshot](../topology/Topology.png) was supplied on **9 November 2026**; it does **not** automatically update saved device configurations.

**Goal:** Preserve every original non-sensitive setting and interface. The public repository does **not** contain raw usernames/password hashes, SNMPv3 authentication secrets, TACACS keys, OSPF/BGP passwords, IKE pre-shared keys, ASA failover secrets or PKI certificate/private-key blocks. Sanitized files are **not deployable backups**.

## Original CML source mapping

Cisco CML embeds file names such as `ios_config.txt`, `day0-config`, `boot.sh` and `dnsmasq.conf` within each node. GitHub uses a per-device folder/name so files cannot overwrite one another; their substantive content comes from the corresponding original entries.

| CML node | CML source file | Published file | Source lines | Treatment |
| --- | --- | --- | ---: | --- |
| ISP-A-R1 | `ios_config.txt` | [`ISP-A-R1.cfg`](../configs/isp/ISP-A-R1.cfg) | 176 | Line-preserving redaction |
| ISP-B-R1 | `ios_config.txt` | [`ISP-B-R1.cfg`](../configs/isp/ISP-B-R1.cfg) | 179 | Line-preserving redaction |
| AMS-HQ-EDGE1 | `ios_config.txt` | [`AMS-HQ-EDGE1.cfg`](../configs/hq/AMS-HQ-EDGE1.cfg) | 442 | Line-preserving redaction |
| AMS-HQ-EDGE2 | `ios_config.txt` | [`AMS-HQ-EDGE2.cfg`](../configs/hq/AMS-HQ-EDGE2.cfg) | 398 | Line-preserving redaction |
| RTM-BR-R1 | `ios_config.txt` | [`RTM-BR-R1.cfg`](../configs/branch/RTM-BR-R1.cfg) | 445 | Line-preserving redaction |
| RTM-BR-R2 | `ios_config.txt` | [`RTM-BR-R2.cfg`](../configs/branch/RTM-BR-R2.cfg) | 445 | Line-preserving redaction |
| RTM-BR-ACC1 | `ios_config.txt` | [`RTM-BR-ACC1.cfg`](../configs/branch/RTM-BR-ACC1.cfg) | 240 | Line-preserving redaction |
| AMS-HQ-DIST1 | `ios_config.txt` | [`AMS-HQ-DIST1.cfg`](../configs/hq/AMS-HQ-DIST1.cfg) | 432 | Line-preserving redaction |
| AMS-HQ-DIST2 | `ios_config.txt` | [`AMS-HQ-DIST2.cfg`](../configs/hq/AMS-HQ-DIST2.cfg) | 383 | Line-preserving redaction |
| AMS-HQ-ACC1 | `ios_config.txt` | [`AMS-HQ-ACC1.cfg`](../configs/hq/AMS-HQ-ACC1.cfg) | 297 | Line-preserving redaction |
| AMS-HQ-ACC2 | `ios_config.txt` | [`AMS-HQ-ACC2.cfg`](../configs/hq/AMS-HQ-ACC2.cfg) | 305 | Line-preserving redaction |
| AMS-HQ-DNS-DHCP1 | `dnsmasq.conf` | [`dnsmasq.conf`](../configs/services/AMS-HQ-DNS-DHCP1/dnsmasq.conf) | 744 | Original file restored, including stock comments |
| AMS-HQ-DNS-DHCP1 | `boot.sh` | [`boot.sh`](../configs/services/AMS-HQ-DNS-DHCP1/boot.sh) | 19 | Preserved |
| AMS-HQ-SYSLOG1 | `boot.sh` | [`boot.sh`](../configs/services/AMS-HQ-SYSLOG1/boot.sh) | 16 | Preserved |
| AMS-HQ-TACACS1 | `tac_plus.conf` | [`tac_plus.conf`](../configs/services/AMS-HQ-TACACS1/tac_plus.conf) | 27 | Passwords/user blocks redacted |
| AMS-HQ-TACACS1 | `boot.sh` | [`boot.sh`](../configs/services/AMS-HQ-TACACS1/boot.sh) | 14 | Preserved |
| AMS-HQ-NMS1 | `boot.sh` | [`boot.sh`](../configs/services/AMS-HQ-NMS1/boot.sh) | 14 | Preserved |
| AMS-HQ-FW1 | `day0-config` | [`AMS-HQ-FW1.cfg`](../configs/security/AMS-HQ-FW1.cfg) | 300 | Private PKI/cert block and credentials redacted |
| AMS-HQ-FW2 | `day0-config` | [`AMS-HQ-FW2.cfg`](../configs/security/AMS-HQ-FW2.cfg) | 290 | Private PKI/cert block and credentials redacted |
| AMS-HQ-PERIM-SW1 | `ios_config.txt` | [`AMS-HQ-PERIM-SW1.cfg`](../configs/security/AMS-HQ-PERIM-SW1.cfg) | 236 | Certificate chain and credentials redacted |

**Integrity review:** For 17 saved files (11 IOS/IOS-XE configs plus 6 service-related files), the published snapshots retain the original line count, replacing only sensitive lines where applicable. The **744-line `dnsmasq.conf` has been restored from the original CML export**, including its explanatory comments. ASA FW1/FW2 and perimeter-switch source files include PKI/certificate blocks that are **intentionally omitted**, rather than published.

## What is still outdated?

The original 2 November export predates the owner's corrected ASA `outside` interface spelling and later November 9 test results. Those later outcomes are documented in [CCNP LAB DESIGN SUMMARY](ccnp-lab-design-summary-2026-11-09.md), but are not automatically present in the older saved configurations.

For a current configuration update, export and share a **new CML YAML**. It can be used as input without committing the YAML itself. Newer sanitized snapshots should be checked for secrets and compared with the existing files before replacement.
