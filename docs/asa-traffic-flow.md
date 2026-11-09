# ASA HA, PBR and traffic-flow experiment

**Later 9 November findings:** ASA stateful TCP failover and five final security-policy packet-tracer checks passed. Read [full lab summary](ccnp-lab-design-summary-2026-11-09.md) and [TCP failover experiment](asa-stateful-tcp-failover.md). The older tests below document earlier stages and must not be mistaken for the latest ACL state.

## ASA high availability

Last observed states:

- `AMS-HQ-FW1`: **Active**
- `AMS-HQ-FW2`: **Standby Ready**

The lab has separate ASA failover and stateful links, as well as inside, outside, DMZ and management segments. These are observed checkpoints; they do not imply zero-loss failover.

## VLAN 10 — selective firewall forwarding

1. A test client uses `10.10.10.138`.
2. Policy-based routing at campus distribution steers selected VLAN 10 traffic towards the ASA inside path.
3. In an **earlier successful test**, ASA PAT translated traffic to `192.0.2.20`.
4. The ASA outside next hop was `192.0.2.18`, allowing the test to reach `8.8.8.8`. The 2 November CML export had the `nameif` misspelled as `outisde`; the lab owner has since corrected it to `outside`. The saved export is historical, so verify the current `nameif`, NAT, MTU and route references on both ASA units before applying commands.

VLAN 20 was described in the tested design as following regular OSPF forwarding rather than the same PBR path. **Do not assume every VLAN traverses the ASA.**

## Expected ACL drop — later test

The inbound ASA `ACL-INSIDE-TEST` intentionally denied ICMP from `10.10.10.138` to `8.8.8.8`.

The earlier ASA `packet-tracer` showed:

- `INPUT-ROUTE-LOOKUP`: ALLOW, next hop `192.0.2.18` via outside.
- `ACCESS-LIST`: DROP because of `ACL-INSIDE-TEST`.

This was a **successful negative test**. It must not be presented as Internet connectivity passing in the most recent state.

Before repeating Internet validation, review the intended ASA ACL and safely replace the temporary test rule.
