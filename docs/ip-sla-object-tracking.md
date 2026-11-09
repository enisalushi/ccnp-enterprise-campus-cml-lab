# Stage 1.13 — IP SLA and Object Tracking

**9 November 2026 checkpoint.**

## Intended behavior

Probe ASA inside interface `10.255.100.4` from HQ distribution. The long-term design is to couple the SLA state to a tracked primary default route, with a controlled Null0 fail-closed fallback rather than an OSPF default that bypasses the firewall.

## Verified on AMS-HQ-DIST1

| Parameter | Result |
|---|---|
| Platform | IOL-L2 IOS-XE 17.18.2 |
| SLA operation | 10 |
| Probe | ICMP echo `10.255.100.4`, source `Vlan80` |
| Frequency / timeout | 5 s / 1000 ms |
| Observations | 31 successes, 0 failures |
| RTT / latest status | 1 ms / OK |

**IP SLA configuration (Global Config → IP SLA Config → Global Config):**

```cisco
ip sla 10
 icmp-echo 10.255.100.4 source-interface Vlan80
 timeout 1000
 frequency 5
exit
ip sla schedule 10 life forever start-time now
```

**Verification — Privileged EXEC:**

```cisco
show ip sla configuration 10
show ip sla statistics 10
show ip route 0.0.0.0
```

## Blocker: Enhanced Object Tracking

The `track` command was **unrecognized** in the tested IOL-L2 image. Therefore, attaching SLA 10 to a track object and a tracked static route **was not completed**.

As verified in the reported routing checkpoints:

- Primary default: ASA next hop `10.255.100.4`, **AD 1**.
- Backup default: `Null0`, **AD 100**, intended to suppress OSPF default **AD 110** bypass.
- A primary static route that stays installed despite ASA inaccessibility can still blackhole traffic. Null0 does not detect the ASA outage by itself.

**Next experiment:** Use a platform with `track` support, bind the SLA to the route, and verify withdrawal/recovery under controlled ASA reachability loss. Do not claim this test passed until route-table evidence is captured.

[9 November CCNP lab checkpoint](ccnp-lab-design-summary-2026-11-09.md)
