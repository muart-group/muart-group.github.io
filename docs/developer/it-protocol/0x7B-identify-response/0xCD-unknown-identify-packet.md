# Command `0xCD`: Unknown Identify Packet

:::note
This command ID was extracted from the KirigamineRemote application and got a response on a NA unit.

The exact purpose of this packet and when (if at all) it's sent in the field is currently unknown.
:::


| Byte  | Purpose           | Possible Values | Supported by mUART | Notes |
|-------|-------------------|-----------------|--------------------|-------|
| 0     | CommandType       | 0xCD            |                    |       |
| 1-8   | Unknown           | 0x03            |                    |       |
| 9     | Tonnage?          | 0x0-0x0         |                    |       |
| 10-15 | Unknown           | 0x03            |                    |       |

## Byte 9 Tonnage

| Hex Flag (Byte 9) | Metric Capacity Class | Equivalent BTU Tonnage | Common Model Match Examples |
| :---              | :---   | :--- | :--- |
| **`0x00`**        | 1.5 kW | ~5,000 BTU (0.42 Tons) | MSZ-AP15VGK, MSZ-EF15VG |
| **`0x01`**        | 1.8 kW | ~6,000 BTU (0.50 Tons) | MSZ-AP18VGK |
| **`0x02`**        | 2.0 kW | ~7,000 BTU (0.58 Tons) | MSZ-AP20VG, MSZ-LN20VG |
| **`0x03`**        | 2.5 kW | ~9,000 BTU (0.75 Tons) | MSZ-AP25VG, MSZ-LN25VG, MSZ-EF25VG |
| **`0x04`**        | 3.5 kW | ~12,000 BTU (1.00 Ton) | MSZ-AP35VG, MSZ-LN35VG, MSZ-EF35VG |
| **`0x05`**        | 4.2 kW | ~15,000 BTU (1.25 Tons) | MSZ-AP42VG |
| **`0x06`**        | 5.0 kW | ~18,000 BTU (1.50 Tons) | MSZ-AP50VG, MSZ-LN50VG |

### Sample Packets

```
[FC.7B.01.30.10] CD.A0.BE.A0.BE.A0.BE.18.00.00.00.00.00.00.00.00 45  // MSZ-FS06NA
[FC.7B.01.30.10] CD.A0.BE.A0.BE.A0.BE.04.11.02.B4.0A.00.00.00.03 85  // MSZ-AY35VGKP
```
