# Infrastructure services

These files are **saved Cisco CML configuration/startup snapshots**, not proof the services are currently running.

## Published files

| CML node | Files | Lab service |
| --- | --- | --- |
| AMS-HQ-DNS-DHCP1 | [dnsmasq.conf](../configs/services/AMS-HQ-DNS-DHCP1/dnsmasq.conf), [boot.sh](../configs/services/AMS-HQ-DNS-DHCP1/boot.sh) | DHCP/DNS |
| AMS-HQ-SYSLOG1 | [boot.sh](../configs/services/AMS-HQ-SYSLOG1/boot.sh) | Syslog collector |
| AMS-HQ-TACACS1 | [tac_plus.conf](../configs/services/AMS-HQ-TACACS1/tac_plus.conf), [boot.sh](../configs/services/AMS-HQ-TACACS1/boot.sh) | TACACS+ |
| AMS-HQ-NMS1 | [boot.sh](../configs/services/AMS-HQ-NMS1/boot.sh) | Network monitoring |

## IP addressing

- DNS/DHCP: `10.10.70.10/24`
- Syslog: `10.10.70.40/24`
- TACACS+: `10.10.70.60/24`
- NMS: `10.10.70.70/24`
- Default gateway for each services node: `10.10.70.1`

The `dnsmasq.conf` defines DHCP pools for HQ VLANs 10, 20, 30, 40 and 60, and branch VLANs 110, 120, 130, 140 and 160. It configures `enis.lab` DNS mappings and DHCP logging.

**TACACS+ redaction:** Client secret, usernames and their password blocks have been omitted deliberately. The published `tac_plus.conf` retains safe group authorization structure only; it is not a functioning server configuration.

**Security review item:** The archived DNS/DHCP startup script runs `chmod 777 /var/ftpd`. That is overly permissive outside a controlled test environment; review file ownership and narrower permissions before adapting it for other deployments.

## Verification (Linux shell)

```bash
ip address show
ip route
ss -lntup
```

Use application-specific logs and known test clients to confirm DHCP lease allocation, DNS answers, TACACS+ authorizations and syslog receipt.

[Back to overview](../README.md)
