# CCNP Enterprise Campus  CLI Evidence Capture Plan

Run these commands in **Cisco CML → select the device → Console**, from **Privileged EXEC** (`enable` if needed). Take a real screenshot with the **hostname, command and decisive output visible**, then upload the screenshots in our chat for review. No CML YAML or raw secrets should be committed.

## Batch 1  Campus and routing

**AMS-HQ-ACC1 — EtherChannel and 802.1Q trunks**

```cisco
show etherchannel summary
show interfaces trunk
```

Look for correctly bundled Po11/Po12 member links, trunk VLANs and forwarding status. Save as `campus/acc1-etherchannel.png`.

**AMS-HQ-DIST1 and AMS-HQ-DIST2 — First-hop redundancy and OSPF**

Run on **both** devices:

```cisco
show standby brief
show ip ospf neighbor
```

Document the Active/Standby gateway roles and OSPF FULL adjacencies. Two images: `campus/dist1-hsrp.png`, `campus/dist2-hsrp.png`.

**AMS-HQ-EDGE1  OSPF, BGP and ISP-A track**

```cisco
show ip ospf neighbor
show bgp ipv4 unicast summary
show track 10
show ip route 0.0.0.0
```

OSPF neighbor FULL and BGP State/PfxRcd numeric (rather than Idle/Active) are meaningful. Names: `routing/edge1-ospf.png`, `routing/edge1-bgp.png`, `routing/edge1-track.png`.

**AMS-HQ-EDGE2  BGP and ISP-B track**

```cisco
show bgp ipv4 unicast summary
show track 20
show ip route 0.0.0.0
```

Captures the alternate ISP and routing state. Name: `routing/edge2-bgp-track.png`.

## Batch 2 — Branch, GRE/IPsec and forwarding path

**RTM-BR-R1 — Tunnel10, OSPF and IKE/IPsec**

```cisco
show ip ospf neighbor
show crypto isakmp sa
show crypto ipsec sa
show ip route 10.10.70.10
traceroute 10.10.70.10
```

IKEv1 `QM_IDLE` (when applicable) establishes a negotiated SA; real IPsec forwarding requires **encapsulation and decapsulation counters increasing** during generated tunnel traffic. Traceroute documents only the observed hop path, not encryption. Names: `vpn/br-r1-isakmp.png`, `vpn/br-r1-ipsec.png`, `routing/br-r1-traceroute.png`.

**RTM-BR-R2  Tunnel20 and VRRP**

```cisco
show crypto isakmp sa
show crypto ipsec sa
show vrrp brief
```

Second tunnel and branch default-gateway redundancy. Names: `vpn/br-r2-ipsec.png`, `campus/br-r2-vrrp.png`.

## Batch 3  QoS

**AMS-HQ-EDGE1 — ISP-A shaping and GRE QoS**

```cisco
show policy-map interface Ethernet0/2
show policy-map interface Tunnel10
```

Saved config attaches WAN shaper to `Ethernet0/2` and GRE QoS to `Tunnel10`. Capture policy names, shaping rate, traffic class counters and drops if present. Counter increases under traffic provide stronger evidence than the policy alone. Names: `qos/edge1-isp-shaping.png`, `qos/edge1-gre-qos.png`.

**AMS-HQ-EDGE2  ISP-B and GRE QoS**

```cisco
show policy-map interface Ethernet0/2
show policy-map interface Tunnel20
```

Second provider, different edge and tunnel. Name: `qos/edge2-isp-gre.png`.

## Batch 4  ASA NAT, connection state and application traffic

**The ASA that is CURRENTLY Active (FW1 or FW2)**

```cisco
show failover
show nat detail
show xlate
show conn
show access-list
```

First confirm which chassis is Active with `show failover`. `show nat detail` demonstrates configured DMZ static NAT. Generate real HQ VLAN10 traffic to populate dynamic PAT `show xlate`; initiate HTTP to the published DMZ service for `show conn`. Names: `security/asa-failover.png`, `security/asa-nat.png`, `security/asa-xlate.png`, `security/asa-conn.png`.

**AMS-HQ-EDGE1  Actual DMZ HTTP response**

```cisco
telnet 192.0.2.22 8080
```

Type the following into the established Telnet connection, then send one blank line:

```text
GET / HTTP/1.0
```

Capture the real HTTP response and verify it correlates to `show conn`. Name: `security/dmz-http-response.png`.

## Evidence quality and publication

- **GitHub:** Publish every accepted and captioned screenshot in `evidence/campus/`, `evidence/routing/`, `evidence/vpn/`, `evidence/qos/` or `evidence/security/`. Caption each image with **objective, command, actual observed result and packet behavior**.
- **LinkedIn:** Select approximately **6–8 strongest visual proofs** from multiple nodes: topology; OSPF/BGP; GRE/IKE/IPsec; QoS; NAT/xlate; ASA stateful TCP failover; HSRP. Use fewer if protocol checks are not operational.
- Do **not** post router passwords, SNMP secrets, TACACS keys, VPN keys, tokens or private certificates. Do not alter command output or invent packet counters.
- If a command is unsupported or returns unexpected status, **send the output as-is**. It becomes troubleshooting material, not a completed-implementation claim.
- Screenshots are not yet present here; this is a command-and-capture plan. [View completed implementation summary](../docs/ccnp-lab-design-summary-2026-11-09.md).

**Start with Batch 1 (ACC1, DIST1, DIST2 and EDGE1).** Once those screenshots are reviewed, continue with the branch/VPN, QoS and ASA batches.
