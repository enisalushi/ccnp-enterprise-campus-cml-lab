# Perimeter switching and ASA failover

**Source:** Cisco CML snapshot from 2026-11-02 plus previously observed testing. Saved configs are historical and have not been re-exported after the reported ASA outside-name correction.

## Published configurations

- [ASA FW1](../configs/security/AMS-HQ-FW1.cfg)
- [ASA FW2](../configs/security/AMS-HQ-FW2.cfg)
- [Perimeter switch](../configs/security/AMS-HQ-PERIM-SW1.cfg)

## Saved security topology

The ASA pair has inside, outside, DMZ, management, failover and stateful failover links. Saved unit roles are *primary* and *secondary*, respectively. Previously observed operational state was **FW1 Active / FW2 Standby Ready**; no fresh failover evidence accompanies this archive.

The exported security-side addresses include:

| Segment | Saved active/standby addressing |
| --- | --- |
| Inside | `10.255.100.4` / `10.255.100.5` |
| Outside | `192.0.2.20` / `192.0.2.21` |
| DMZ | `172.16.70.1` / `172.16.70.2` |
| Management | `10.10.70.80` / `10.10.70.81` |
| Failover | `10.255.200.1/30` + standby `10.255.200.2` |
| Stateful link | `10.255.201.1/30` + standby `10.255.201.2` |

## Naming correction (historical export)

**The original YAML export uses `outisde`** (misspelled) as the ASA `nameif`, including NAT, MTU and route references. The lab owner reports having corrected this to **`outside` afterward**. The repository preserves the historical snapshot rather than changing the exported data. Obtain an updated saved configuration or running-config capture to verify that all dependent references were migrated.

The FW2 saved configuration reports `hostname AMS-HQ-FW1`. In an ASA failover pair, replicated configuration may include the same hostname; rely on `show failover` and unit roles, not hostname alone, to determine which chassis is active.

## Tested traffic path

Earlier VLAN 10 traffic from `10.10.10.138` reached `8.8.8.8` via ASA PAT. A later intentional inside ACL negative test denied ICMP to that destination. These are **separate historical tests**; do not treat the earlier passing flow as proof of current access.

## Verification checklist

**ASA — Privileged EXEC mode:**

```cisco
show failover
show interface ip brief
show route
show nat detail
show access-group
show access-list
show xlate
packet-tracer input inside icmp 10.10.10.138 8 0 8.8.8.8 detailed
```

Before changing the ACL, inspect the current configuration on the ASA pair and verify the intended security policy. Measure traffic continuity in a controlled HA test before claiming failover recovery time.

[Back to overview](../README.md)
