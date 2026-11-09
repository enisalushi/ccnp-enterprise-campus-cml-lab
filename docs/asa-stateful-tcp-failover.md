# ASA Active/Standby: Existing TCP Session Survives Failover

**Verified in earlier lab discussion, 4 November 2026.**

## Objective and traffic

Test *stateful* ASA failover using an existing TCP connection, not a fresh session after failover.

- Client: **AMS-HQ-EDGE1** `192.0.2.18`
- Published DMZ IP/port: **`192.0.2.22:8080`**
- Real server: **`172.16.70.10:8080`**, Python HTTP
- NAT: static `172.16.70.10` ↔ `192.0.2.22`

## Test sequence

1. Establish a TCP connection from EDGE1 to the published HTTP endpoint **before** failover.
2. Inspect the connection on the active ASA.
3. Trigger controlled ASA role switchover; **FW2 becomes Active**.
4. Confirm the same existing TCP connection appears on FW2.
5. Send an HTTP GET on the original established session. **HTTP 200 OK** returned successfully.

A preliminary attempt with only Enter keystrokes closed Telnet; a subsequent valid HTTP request succeeded. The correct conclusion is **state preservation of the original session**, not failure of state synchronization.

### Relevant commands

**EDGE1 — Privileged EXEC mode:**

```cisco
telnet 192.0.2.22 8080
```

Once Telnet is connected, type this HTTP text into the active TCP session, then one empty line:

```text
GET / HTTP/1.0
```

**ASA — Privileged EXEC mode:**

```cisco
show failover
show conn address 172.16.70.10
```

**ASA — Global Configuration mode (controlled test only, on the local Active unit):**

```cisco
no failover active
```

Check which unit is Active before changing failover state.

## Conclusion

**Passed:** A pre-existing TCP session survived Active/Standby transition and continued handling HTTP. **Not measured:** exact convergence time, zero loss for every protocol, or all link/ISP failure combinations.

[9 November CCNP lab checkpoint](ccnp-lab-design-summary-2026-11-09.md)
