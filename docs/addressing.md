# Addressing reference

Partial addresses from existing lab notes. **Do not infer unlisted interfaces or networks.**

| Purpose | Observed / documented value |
| --- | --- |
| HQ VLANs 10–60 | 10.10.<VLAN>.0/24 pattern |
| HQ services | 10.10.70.0/24 |
| Branch VLANs 110–160 | 10.20.<VLAN>.0/24 pattern |
| Campus native VLAN | VLAN 999 |
| NMS | 10.10.70.70 |
| ASA monitoring address | 10.10.70.80 |
| Syslog | 10.10.70.40 |
| ASA NTP source | 10.10.70.2 |
| VLAN 10 test source | 10.10.10.138 |
| ASA translated test IP | 192.0.2.20 |
| ASA outside next-hop test | 192.0.2.18 |
| ASA failover/state link lab networks | 10.255.200.0/30 and 10.255.201.0/30 |

IP assignments should be checked against the latest running configurations. The `192.0.2.0/24` range is reserved for documentation.
