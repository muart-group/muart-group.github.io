# Command `0xCD`: Unknown Identify Packet

:::note
This command ID was extracted from the KirigamineRemote application and got a response on a NA unit.

The exact purpose of this packet and when (if at all) it's sent in the field is currently unknown.
:::


| Byte | Purpose           | Possible Values | Supported by mUART | Notes |
|------|-------------------|-----------------|--------------------|-------|
| 0    | CommandType       | 0xCD            |                    |       |
| 1-6  | Setpoint limits?  |                 |                    | Unconfirmed — see below |
| 7-13 | Unit Capabilities | See below       |                    |       |
| 14-15| Unknown           |                 |                    |       |

## Unit Capabilities (per 霧ヶ峰REMOTE v5.3.1)

The 霧ヶ峰REMOTE (Kirigamine REMOTE) Android application (v5.3.1) contains a `parseCdValue`
handler. Flag names below are the app's own.

| Byte | Bitmask | App flag                      | Notes                                              |
|------|---------|-------------------------------|----------------------------------------------------|
| 7    | 0x01    | `isDehumDispPercent`          | Dehumidify shown as a percentage                   |
| 7    | 0x02    | `isPowerSavingSupport`        | True when `0x02` set **and** `0x20` clear          |
| 7    | 0x04    | `isRemoteHandle`              |                                                    |
| 7    | 0x10    | `isEffectiveTemperature`      |                                                    |
| 7    | 0x20    | (inverts the power-saving test) |                                                  |
| 8    | 0x40    | `isSupportVentilationAssist`  |                                                    |
| 13   | 0x40    | `isSupportOnlineSerialWriting`|                                                    |

:::note
Bytes 1-6 are `A0 BE A0 BE A0 BE` on all three samples below. That matches both the position
and encoding of the `0xC9` setpoint block (bytes 10-15) — `0xA0` → 16 °C, `0xBE` → 31 °C under
`(value - 128) / 2` — which would make them three min/max setpoint pairs. Unverified.
:::

### Sample Packets

```
[FC.7B.01.30.10] CD.A0.BE.A0.BE.A0.BE.18.00.00.00.00.00.00.00.00 45  // MSZ-FS06NA
[FC.7B.01.30.10] CD.A0.BE.A0.BE.A0.BE.04.11.02.B4.0A.00.00.00.03 85  // MSZ-AY35VGKP
[FC.7B.01.30.10] CD.A0.BE.A0.BE.A0.BE.E0.10.01.B4.0F.07.00.00.00 A2  // MLZ-KP18NA
```
