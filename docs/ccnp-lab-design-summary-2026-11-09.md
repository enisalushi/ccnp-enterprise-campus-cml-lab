# CCNP LAB DESIGN SUMMARY — 9 November 2026

**Source:** Earlier ChatGPT discussion titled **CCNP LAB DESIGN SUMMARY**. The results below are the lab owner's reported checks through **9 November 2026**, not newly executed tests. The configurations already in `configs/` were exported **2 November 2026** and may therefore predate these fixes. No CML YAML is published.

## Enterprise CML topology

- Amsterdam HQ: ACC1/ACC2, DIST1/DIST2, EDGE1/EDGE2, ASA FW1/FW2, perimeter switch, infrastructure services
- Rotterdam: BR-R1/BR-R2 and BR-ACC1
- Upstream: ISP-A-R1 and ISP-B-R1
- BGP ASNs: HQ **65010**, branch **65020**, ISP A **65100**, ISP B **65200**
- HQ OSPF **area 0**; tunnel/branch **area 10**
- Features: VLAN, LACP, Rapid PVST+, HSRP, VRRP, eBGP/iBGP, GRE/IPsec, NAT/PAT, PBR, ASA HA, DMZ and management services

The 2 November export contained **28 nodes**, **51 links**, and **20 saved config files for 18 configured nodes**; the [topology screenshot](../topology/Topology.png) is retained.

## Verified discussion checkpoints

| Topic | Test result | Status |
|---|---|---|
| ASA Active/Standby | FW1/FW2 synced, failover checked | Passed |
| Stateful TCP failover | Existing TCP session EDGE1 → published Python HTTP DMZ service retained on newly Active FW2; HTTP GET over original session returned **200 OK** | Passed |
| Static DMZ NAT | `172.16.70.10` → `192.0.2.22`; real HTTP service TCP `8080` | Passed |
| Dynamic PAT | VLAN 10 `10.10.10.138` → ASA outside `192.0.2.20`; previous live ICMP test **173/173** replies | Passed in tested scenario |
| VLAN 10 HSRP | DIST1 → DIST2 switchover with **zero observed ping loss** in that run | Passed in tested scenario |
| ASA policy | Five final `packet-tracer` checks returned expected ALLOW/DROP | Passed |
| Default-route design | DIST1/DIST2 route via ASA `10.255.100.4` **AD 1**; Null0 fallback default **AD 100**; EDGE and branch PBR attachments checked | Configured / checked |
| IP SLA 10 | Probe to ASA inside `10.255.100.4` from `Vlan80`, **RTT 1 ms; 31 successes; 0 failures; return OK** | Passed |
| Enhanced Object Tracking | `track` command unrecognized on **IOL-L2 IOS-XE 17.18.2** | Blocked |
| Real branch-client Internet connection | ASA policy simulation passed, but end-to-end connection not demonstrated | Pending |
| Full upstream/edge outage | End-to-end failure scenarios not demonstrated | Pending |

An earlier deliberate ACL negative test denied VLAN 10 ICMP to 8.8.8.8. That was an *earlier stage*, not the final firewall-policy outcome.

## Five final ASA packet-tracer checks

These were reported as **five passing simulation outcomes**, not five application-level traffic tests.

| Source | Destination and service | Expected and observed |
|---|---|---|
| HQ VLAN10 `10.10.10.138` | DMZ real IP `172.16.70.10:443` | **ALLOW** |
| Guest VLAN60 `10.10.60.100` | DMZ `172.16.70.10:8080` | **DROP** |
| HQ VLAN30 `10.10.30.100` | Internet `6.6.6.6:443` | **ALLOW** |
| Branch VLAN120 `10.20.120.100` | Internet `6.6.6.6:443` | **ALLOW** |
| EDGE1 outside `192.0.2.18` | Published DMZ `192.0.2.22:8080` | **ALLOW** |

## Stateful connection preservation

EDGE1 at `192.0.2.18` opened a TCP session to `192.0.2.22:8080`, mapped to a Python HTTP server at `172.16.70.10:8080`. After triggering ASA failover, FW2 became Active and showed the original connection. Sending an HTTP GET on that **same existing session** returned **200 OK**.

This proves state preservation for that tested flow. It **does not** establish zero packet loss for all traffic types, sub-second failover, or universal connection survival. See [ASA TCP failover experiment](asa-stateful-tcp-failover.md).

## Default routing, inspection and limitations

DIST1/DIST2 used a static default route via ASA inside `10.255.100.4`, AD **1**, plus a floating default to `Null0`, AD **100**. This is intended to take precedence over OSPF-learned defaults with AD **110**, preventing fallback that bypasses the ASA. However, the primary static route can remain installed even when the ASA is unreachable; a blackhole is then possible without route tracking.

A previous **2 November** export showed DIST1 PBR with an ACL naming mismatch (`ACL-VLAN10-ASA-TEST` versus `ACL-VLAN-10-ASA-TEST`) and no matching DIST2 VLAN10 PBR. The newer conversation verifies subsequent routing checks but does not contain a newer full config export proving whether that exact ACL mismatch was fixed.

## Stage 1.13: IP SLA / object tracking

- Tested on **AMS-HQ-DIST1**, IOL-L2 IOS-XE **17.18.2**
- `ip sla 10`: ICMP to ASA inside `10.255.100.4`, source `Vlan80`
- Frequency **5 seconds**; timeout **1000 ms**
- Observed **31 successes, 0 failures, RTT 1 ms, latest result OK**
- **Object tracking remains incomplete:** `track` is unavailable on the tested image, so no tracked primary static route was verified.

See [IP SLA and object-tracking limitation](ip-sla-object-tracking.md).

## Next work

1. Re-export sanitized current device configs (ASA `outside` spelling, updated ACL/NAT/PBR/default routes). Existing exports remain a historical snapshot.
2. Verify the saved DIST1 PBR ACL name and whether DIST2 is configured to retain the desired inspection policy after HSRP failover.
3. Complete SLA-driven tracked routing **on an image supporting object tracking**; test withdrawal and restoration.
4. Run actual branch-client Internet traffic and controlled ISP/WAN outage scenarios.
5. Capture dated `show` output for routing neighbors, ASA session/NAT state, and failover paths.

**Scope:** The reported lab checks are documented, not independently repeated during this GitHub publication. The CML YAML and unsanitized credential-bearing files are not uploaded.
