# Device configurations

Configurations will be added **incrementally** after exporting and checking the current running configs from CML.

Suggested future grouping:

- `hq/` — campus distribution, access and WAN edge
- `branch/` — Rotterdam routers and access switch
- `isp/` — ISP simulation
- `security/` — sanitized ASA configuration
- `servers/` — redacted supporting service configuration

Never publish passwords, hashes, SNMPv3 auth/privacy secrets, TACACS keys, VPN pre-shared keys, private certificates or tokens. A `.gitignore` cannot protect secrets pasted into committed text.
