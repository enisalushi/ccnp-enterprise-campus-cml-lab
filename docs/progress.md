# Progress and validation log

## 9 November 2026 — New saved configurations published

The uploaded CML export contains **28 nodes, 52 links and 20 configuration files from 18 nodes**. All 20 sanitized files in [configs/](../configs/) have been refreshed. [Export review](latest-cml-config-snapshot-2026-11-09.md).

New saved items: edge ISP IP SLA/track, QoS shaping/marking, branch/edge PBR and ASA FW1 `outside` correction. **DIST2's Null0 fallback was added afterward**, according to the lab owner, but is not in the exported file; exact administrative distance awaits verification. FW2 still saves `outisde`. This is configuration evidence, not a live operational retest.


## 9 November 2026 — latest CCNP LAB DESIGN SUMMARY checkpoint

Detailed results: [lab summary](ccnp-lab-design-summary-2026-11-09.md), [ASA stateful TCP](asa-stateful-tcp-failover.md), [IP SLA / tracking](ip-sla-object-tracking.md).

| Milestone | Reported observation | Status |
|---|---|---|
| ASA Active/Standby synchronization | FW1/FW2 synchronized | Passed |
| Stateful TCP failover | Existing session survived FW1→FW2; HTTP GET returned 200 OK on original connection | Passed |
| DMZ static NAT and real HTTP | 172.16.70.10:8080 → 192.0.2.22:8080 | Passed |
| ASA security policy | Five final packet-tracer ALLOW/DROP checks matched expectations | Passed |
| Dynamic PAT | HQ/branch NAT configured; HQ VLAN10 prior actual ping traffic passed | Passed in tested scope |
| VLAN10 HSRP switchover | DIST1→DIST2 with zero observed ICMP loss in that run | Passed in tested scope |
| Default route & firewall breakout | DIST1/DIST2 primary default via ASA AD1; Null0 default AD100, EDGE/branch PBR attachments checked | Configured |
| IP SLA 10 | To ASA inside 10.255.100.4 from Vlan80; 31 successes / 0 failures / 1ms RTT | Passed |
| Tracked default route | `track` unsupported by IOL-L2 IOS-XE 17.18.2 | Blocked |
| Branch live Internet access | ASA packet-tracer allowed simulated branch flow; actual branch end-to-end flow not yet tested | Pending |
| Full ISP/edge outages | Controlled end-to-end failure tests not done | Pending |

These are **reported results from the prior chat**, not retests against the deployed network.

### Outstanding
1. Export new sanitized running configs capturing changes made **after 2 November**, especially the ASA `outside` correction and any later PBR/NAT/ACL work.
2. Confirm whether old DIST1 PBR ACL mismatch and DIST2 policy gap are now resolved.
3. Test route tracking with a supported image; verify fail-closed behavior.
4. Run live branch-client Internet tests and controlled ISP/edge outage tests.
5. Publish timestamps and show-command evidence for all new stages.

---

## 2 November 2026 — previous exported baseline

Cisco CML export: **28 nodes, 51 links, 20 saved configuration files across 18 nodes**; published under [configs](../configs/). These are sanitized historical snapshots, not deployable backups. The old ASA export still spelled `outisde`; the owner corrected `outside` later. The original YAML remains private.
