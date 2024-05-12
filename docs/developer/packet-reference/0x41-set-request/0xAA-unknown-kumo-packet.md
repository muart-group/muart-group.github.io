# Command `0xAA` - Unknown Kumo Packet

Sent from the MHK2 to a Kumo Cloud unit, captured via logic analyzer.

| Byte | Purpose      | Possible Values | Supported by mUART | Notes                |
|------|--------------|-----------------|--------------------|----------------------|
| 0    | Command Type | 0xAA            | No                 |                      |
| 1    | ???          | 0x00, 0x01      |                    |                      |
| 2-5  | ???          | 0x00000000      |                    | Position unconfirmed |

### Sample Packets

```
[FC 41 01 30 10] AA 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 [D3]
```