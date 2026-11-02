# Device configurations

Configurations are being added **incrementally** using the saved CML export. The published files are **selected sanitized excerpts, not complete, deployable running configurations**.

## Published: HQ switching (Stage 1)

- [AMS-HQ-ACC1](hq/AMS-HQ-ACC1.cfg) and [AMS-HQ-ACC2](hq/AMS-HQ-ACC2.cfg) — LACP uplinks, trunks, access and management VLANs.
- [AMS-HQ-DIST1](hq/AMS-HQ-DIST1.cfg) and [AMS-HQ-DIST2](hq/AMS-HQ-DIST2.cfg) — trunks, STP priorities, SVIs, HSRP and OSPF. DIST1 also includes PBR.
- [Implementation and verification notes](../docs/hq-switching-implementation.md).

**Export review finding:** DIST1's PBR route-map ACL reference does not exactly match the ACL definition; check the live device before assuming that policy works.



Suggested future grouping:

- `hq/` — campus distribution, access and WAN edge
- `branch/` — Rotterdam routers and access switch
- `isp/` — ISP simulation
- `security/` — sanitized ASA configuration
- `servers/` — redacted supporting service configuration

Never publish passwords, hashes, SNMPv3 auth/privacy secrets, TACACS keys, VPN pre-shared keys, private certificates or tokens. A `.gitignore` cannot protect secrets pasted into committed text.

## Export snapshot

The CML export reviewed on 2026-11-02 contained 20 saved configuration file entries from 18 nodes. See [configuration inventory](../docs/cml-export-inventory.md).

Before committing a sanitized config, verify all credential material is absent. Credential redaction markers make the document non-deployable by design.
