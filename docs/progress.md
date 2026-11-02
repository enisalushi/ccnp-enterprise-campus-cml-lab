# Progress and validation log

## Snapshot — 2026-11-02

The CML export contains **28 nodes**, **51 links**, and **20 saved configuration files across 18 nodes**. Refer to the [export inventory](cml-export-inventory.md). This exported configuration snapshot is not a live operational verification.


### Included in the evolving lab

- Amsterdam HQ campus and Rotterdam branch with two simulated ISP domains.
- VLANs, trunks, LACP EtherChannel, HSRP and VRRP exercises.
- OSPF area 0, internal/external BGP, GRE/IPsec exercises.
- ASA pair, DMZ/perimeter connectivity, infrastructure monitoring and services.

### Published artifacts

- **All 20 saved configuration files from all 18 configured nodes** are now published as sanitized snapshots (HQ, branch, ISP, perimeter, and services). Full network-interface stanzas are preserved.
- [HQ implementation](hq-switching-implementation.md), [WAN/branch](wan-branch-implementation.md), [perimeter](perimeter-security.md), [services](infrastructure-services.md), and [review findings](review-findings.md).
- DIST1 saved PBR route-map ACL naming mismatch and DIST1-only PBR application noted for follow-up.
- ASA `outside` interface spelling corrected by the lab owner after the uploaded export; current running-config evidence not yet attached.

### Specific observed results

| Area | Observation | Status |
| --- | --- | --- |
| ASA HA | FW1 Active; FW2 Standby Ready | Observed |
| VLAN 10 PAT | 10.10.10.138 to 8.8.8.8 succeeded; PAT to 192.0.2.20 | Passed in earlier test |
| ASA ACL test | Temporary `ACL-INSIDE-TEST` denied ICMP; packet-tracer DROP at access-list phase | Passed — expected deny |
| All-VLAN Internet connectivity | No complete updated evidence in this snapshot | Pending |
| Traffic continuity across ASA HA failover | No current packet-loss/convergence measurement | Pending |

**Important:** The last observed ASA inside ACL includes an intentional ICMP deny for the test flow. The successful PAT test was earlier, not simultaneous with the deny configuration.

### Next milestones

1. Restore or replace the temporary test ACL as intended, then validate the resulting forwarding path.
2. Re-export current running configurations when possible to capture any changes made after 2026-11-02, particularly the ASA `outside` nameif fix.
3. Verify Internet breakout from the HQ and branch VLANs.
4. Measure ASA failover convergence and packet loss during a controlled test.
5. Add changes after each new lab stage with dated results.

This is a lab journal, not a verified production blueprint.
