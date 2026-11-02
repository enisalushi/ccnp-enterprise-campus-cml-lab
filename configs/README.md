# Device configurations

Configurations will be added **incrementally** after exporting and checking the current running configs from CML.

Suggested future grouping:

- `hq/` — campus distribution, access and WAN edge
- `branch/` — Rotterdam routers and access switch
- `isp/` — ISP simulation
- `security/` — sanitized ASA configuration
- `servers/` — redacted supporting service configuration

Never publish passwords, hashes, SNMPv3 auth/privacy secrets, TACACS keys, VPN pre-shared keys, private certificates or tokens. A `.gitignore` cannot protect secrets pasted into committed text.

## Export snapshot

The CML export reviewed on 2026-11-02 contained 20 saved configuration files from 18 nodes. See [configuration inventory](../docs/cml-export-inventory.md).

Before committing a sanitized config, verify all credential material is absent. Credential redaction markers make the document non-deployable by design.
