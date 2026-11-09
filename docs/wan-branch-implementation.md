# WAN, BGP, OSPF and branch implementation

**Source:** Cisco CML saved configuration snapshot, **2026-11-09**. Configured feature evidence only; no fresh live control-plane outputs included.

## Devices and ASNs

| Area | Nodes | BGP ASN |
| --- | --- | --- |
| Amsterdam HQ | [EDGE1](../configs/hq/AMS-HQ-EDGE1.cfg), [EDGE2](../configs/hq/AMS-HQ-EDGE2.cfg) | 65010 |
| Rotterdam | [BR-R1](../configs/branch/RTM-BR-R1.cfg), [BR-R2](../configs/branch/RTM-BR-R2.cfg), [BR-ACC1](../configs/branch/RTM-BR-ACC1.cfg) | 65020 |
| ISP A | [ISP-A-R1](../configs/isp/ISP-A-R1.cfg) | 65100 |
| ISP B | [ISP-B-R1](../configs/isp/ISP-B-R1.cfg) | 65200 |

### Interior and exterior routing

- BGP IPv4 address families, iBGP within the enterprise ASNs, eBGP at the provider handoffs, prefix-lists and route-maps are present in exported device configs.
- OSPF process 10 is present on HQ/branch routers, with **area 0** for HQ routing and **area 10** for the GRE/branch routing domain.
- HQ EDGE1 router ID: `3.3.3.3`; HQ EDGE2: `4.4.4.4`. Branch router IDs: `7.7.7.7` / `8.8.8.8`.
- HQ edge default routes use tracking objects pointing to ISP next-hops. Verify tracking state before relying on failover.

### Latest ISP tracking, QoS and PBR

The 9 November snapshot contains tracked ISP default routes on HQ EDGE1/EDGE2 (SLA/track 10 and 20), 1 Mbps WAN shaping, DSCP classification/marking, and GRE tunnel QoS policies. Both branch routers apply `PBR-BRANCH-INTERNET-HQ` to VLAN 110–160 subinterfaces. Both HQ edge routers apply `PBR-BRANCH-TO-DIST` on their GRE tunnels. These are saved configuration facts; runtime status remains unverified. [Detailed review](latest-cml-config-snapshot-2026-11-09.md).

### GRE over IPsec paths

| Path | HQ endpoint | Branch endpoint |
| --- | --- | --- |
| Tunnel10 | HQ EDGE1 `10.255.10.1/30` | BR-R1 `10.255.10.2/30` |
| Tunnel20 | HQ EDGE2 `10.255.20.1/30` | BR-R2 `10.255.20.2/30` |

IKEv1, crypto maps and tunnel configuration occur in the saved routers. Pre-shared keys have been removed. **These published configurations cannot be deployed without securely restoring authentication.** The export alone does not verify Phase 1/2 SAs or tunnel reachability.

### Branch switching

BR-ACC1 has its own saved configuration. The branch router pair uses VRRP on client VLANs 110–160.

## Live verification (not yet captured)

**Router and switch — Privileged EXEC mode:**

```cisco
show bgp ipv4 unicast summary
show bgp ipv4 unicast
show ip ospf neighbor
show ip route
show interfaces tunnel 10
show interfaces tunnel 20
show crypto isakmp sa
show crypto ipsec sa
show track
show vrrp brief
```

Check commands only on devices supporting the feature and interface; e.g. Tunnel10 and Tunnel20 are on different routers. Save sanitized command outputs with timestamps when the lab is tested.

[Back to overview](../README.md)
