# ASA HA, PBR and traffic-flow experiment

## ASA high availability

Last observed states:

- `AMS-HQ-FW1`: **Active**
- `AMS-HQ-FW2`: **Standby Ready**

The lab has separate ASA failover and stateful links, as well as inside, outside, DMZ and management segments. These are observed checkpoints; they do not imply zero-loss failover.

## VLAN 10 — selective firewall forwarding

1. A test client uses `10.10.10.138`.
2. Policy-based routing at campus distribution steers selected VLAN 10 traffic towards the ASA inside path.
3. In an **earlier successful test**, ASA PAT translated traffic to `192.0.2.20`.
4. The ASA outside next hop was `192.0.2.18`, allowing the test to reach `8.8.8.8`. In the exported ASA configuration, the outside `nameif` is spelled `outisde` (sic); use that literal interface name when validating current commands.

VLAN 20 was described in the tested design as following regular OSPF forwarding rather than the same PBR path. **Do not assume every VLAN traverses the ASA.**

## Expected ACL drop — later test

The inbound ASA `ACL-INSIDE-TEST` intentionally denied ICMP from `10.10.10.138` to `8.8.8.8`.

The ASA `packet-tracer` showed:

- `INPUT-ROUTE-LOOKUP`: ALLOW, next hop `192.0.2.18` via outside.
- `ACCESS-LIST`: DROP because of `ACL-INSIDE-TEST`.

This was a **successful negative test**. It must not be presented as Internet connectivity passing in the most recent state.

Before repeating Internet validation, review the intended ASA ACL and safely replace the temporary test rule.
