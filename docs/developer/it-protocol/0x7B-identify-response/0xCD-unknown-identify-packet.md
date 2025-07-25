# Command `0xCD`: Unknown Identify Packet

:::note
This command ID was extracted from the KirigamineRemote application and got a response on a NA unit.

The exact purpose of this packet and when (if at all) it's sent in the field is currently unknown.
:::


| Byte | Purpose           | Possible Values | Supported by mUART | Notes |
|------|-------------------|-----------------|--------------------|-------|
| 0    | CommandType       | 0xCD            |                    |       |
| 1-15 | Unknown           | 0x03            |                    |       |

### Sample Packets

```
[FC.7B.01.30.10] CD.A0.BE.A0.BE.A0.BE.18.00.00.00.00.00.00.00.00 45  // MSZ-FS06NA
[FC.7B.01.30.10] CD.A0.BE.A0.BE.A0.BE.04.11.02.B4.0A.00.00.00.03 85  // MSZ-AY35VGKP
```
