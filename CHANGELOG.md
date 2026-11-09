# Changelog

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

## Upcoming

- Re-export later CML changes and collect live verification evidence.
- Validate final firewall ACL policy, Internet paths and HA failover.
- Continue publishing new milestones as commits.
