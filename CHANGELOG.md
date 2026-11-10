# Changelog

## 2026-11-09 — Operational evidence gallery published

- Published **29 original CML command screenshots** in six categories: campus, routing, VPN, QoS, security, enterprise services.
- Added verified NTP synchronization on EDGE1 and branch-to-HQ SSH / TACACS+ EXEC authorization evidence.
- Organized every capture with the relevant command, observed result and technical limitations.
- Updated README and project showcase with evidence links and a concise LinkedIn shortlist.
- Kept output and image pixels unchanged; did not publish passwords or CML YAML.

## 2026-11-09 — New CML configurations and DIST2 follow-up

- Refreshed all **20 sanitized saved configuration files** from the uploaded 9 November YAML (28 nodes, 52 links).
- Preserved all saved interfaces and non-sensitive commands, including edge IP SLA/track, QoS shaping/marking, branch/edge PBR and ASA FW1 `outside` correction.
- Documented that the **DIST2 Null0 default was added after the export**, as reported by the lab owner. The published DIST2 saved config remains unchanged until a newer export is available.
- Flagged FW2's saved `outisde` nameif and absence of former distribution SVI PBR attachments.
- Kept CML YAML and authentication/certificate payloads out of GitHub.

## 2026-11-09 — Topology screenshot replaced and source fidelity audited

- Replaced `topology/Topology.png` with the user's newer full-resolution (1545 × 1093) CML screenshot.
- Restored the complete original 744-line `configs/services/AMS-HQ-DNS-DHCP1/dnsmasq.conf`, including comments removed by the earlier condensed extraction.
- Added a file-by-file provenance audit showing original CML source filenames and intentional secret/PKI redactions.
- Kept the historical November 2 device snapshots separate from the November 9 topology and later operational tests.

## 2026-11-09 — CCNP LAB DESIGN SUMMARY published

- Documented ASA stateful TCP failover: original TCP connection retained and HTTP GET returned 200 OK after role transition.
- Added DMZ static NAT, five ASA policy checks, VLAN10 HSRP failover, and fail-closed static/Null0 default routing design.
- Captured IP SLA 10 success and object tracking limitation in IOL-L2 IOS-XE 17.18.2.
- Distinguished completed simulations and live tests from pending branch access and full upstream failures.
- Left saved 2 November configurations and excluded CML YAML unchanged.

## 2026-11-02 — Initial GitHub publication

- Published the architecture and simplified logical topology for the evolving CCNP Enterprise campus/WAN lab.
- Documented currently known design areas, addressing references and lab inventory.
- Recorded the ASA active/standby checkpoint, earlier successful PAT test and later intentional ACL deny test.
- Added verification checklist and placeholders for future sanitized configurations.
- Kept the Cisco CML YAML export out of the repository.

## 2026-11-02 — Stage 1 HQ switching published

- Added sanitized configuration excerpts for ACC1, ACC2, DIST1 and DIST2; subsequently replaced them with **full substantive sanitized snapshots** covering all original interface stanzas.
- Added [HQ switching implementation and verification notes](docs/hq-switching-implementation.md).
- Recorded PBR ACL reference mismatch and asymmetric allowed VLAN lists on ACC2 trunks.
- Documented the ASA `outside` correction reported after the archived export.

## 2026-11-02 — CML export reviewed

- Inspected a user-provided CML export: 28 nodes, 51 links, and saved configurations for 18 nodes.
- Documented configured technologies and node inventory in `docs/cml-export-inventory.md`.
- Corrected OSPF documentation to distinguish HQ area 0 and WAN/branch area 10.
- Kept the original YAML and raw credential-bearing configurations out of this public repository.

## 2026-11-02 — Full saved configuration collection published

- Replaced the four HQ configuration files with the complete sanitized configurations from the original export.
- Published remaining HQ edge, branch, ISP, perimeter and service files: **20 files across 18 configured nodes**.
- Added detailed WAN/branch, ASA, services and review-finding documents.
- Retained the original YAML outside GitHub and explicitly excluded credentials/certificates from public snapshots.

