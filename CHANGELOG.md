# Changelog

## 2026-11-02 — Initial GitHub publication

- Published the architecture and simplified logical topology for the evolving CCNP Enterprise campus/WAN lab.
- Documented currently known design areas, addressing references and lab inventory.
- Recorded the ASA active/standby checkpoint, earlier successful PAT test and later intentional ACL deny test.
- Added verification checklist and placeholders for future sanitized configurations.
- Kept the Cisco CML YAML export out of the repository.

## 2026-11-02 — CML export reviewed

- Inspected a user-provided CML export: 28 nodes, 51 links, and saved configurations for 18 nodes.
- Documented configured technologies and node inventory in `docs/cml-export-inventory.md`.
- Corrected OSPF documentation to distinguish HQ area 0 and WAN/branch area 10.
- Kept the original YAML and raw credential-bearing configurations out of this public repository.

## Upcoming

- Capture sanitized configuration snapshots and new test evidence.
- Validate final firewall ACL policy, Internet paths and HA failover.
- Continue publishing new milestones as commits.
