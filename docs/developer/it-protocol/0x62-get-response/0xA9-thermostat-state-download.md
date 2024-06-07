# Command `0xA9` - Thermostat State Download

This command appears to be used by the MHK2 to request a "download" of a new state from the Kumo Cloud. The request is
sent on a regular cadence by an MHK2.

For the packet used by the MHK to submit its state to the Kumo, see [`0x41 0xA8` - Thermostat State Upload](../0x41-set-request/0xA8-thermostat-state-upload.md).

:::warning
The below table is speculative and not confirmed.

Implementations should not use these definitions until they've been verified more closely.
:::

| Byte | Purpose            | Possible Values                 | Supported by mUART | Notes |
|------|--------------------|---------------------------------|--------------------|-------|
| 0    | CommandType        | 0xA9                            |                    |       |
| 1-4  | Adapter Timestamp  | See See [Timestamps][timestamp] |                    |       |
| 5    | ???                | 0x00                            |                    |       |
| 6    | ???                | 0x00, 0x01                      |                    |       |
| 7    | Heat Setpoint      | Enhanced Temperature            | No                 |       |
| 8    | Cool Setpoint      | Enhanced Temperature            | No                 |       |
| 10   | ???                | 0x00, 0x07                      |                    |       |
| 12   | ???                | 0x00                            |                    |       |

[timestamp]: ../data-types/timestamps.md

### Sample Packets

```
[FC 62 01 30 10] A9 1C E0 AB 71 00 00 AD B3 00 00 00 00 00 00 00 [3C]
[FC 62 01 30 10] A9 1C E0 AB 80 00 00 AD B3 00 07 00 00 00 00 00 [26]
[FC 62 01 30 10] A9 1C E0 AB 8A 00 00 AD B3 00 07 00 00 00 00 00 [1C]
[FC 62 01 30 10] A9 1C E0 AB 94 00 00 AD B3 00 07 00 00 00 00 00 [12]
[FC 62 01 30 10] A9 1C E0 AB 9E 00 00 AD B3 00 07 00 00 00 00 00 [08]
[FC 62 01 30 10] A9 1C E0 AB A7 00 00 AD B3 00 07 00 00 00 00 00 [FF]
[FC 62 01 30 10] A9 1C E0 AB B1 00 00 AD B3 00 07 00 00 00 00 00 [F5]
[FC 62 01 30 10] A9 1C E0 AB BA 00 00 AD B3 00 07 00 00 00 00 00 [EC]
[FC 62 01 30 10] A9 1C E0 AB CA 00 00 AD B3 00 07 00 00 00 00 00 [DC]
[FC 62 01 30 10] A9 1C E0 AB D3 00 00 AD B3 00 07 00 00 00 00 00 [D3]
[FC 62 01 30 10] A9 1C E0 AB DC 00 00 AD B3 00 07 00 00 00 00 00 [CA]
[FC 62 01 30 10] A9 1C E0 AB E5 00 00 AD B3 00 07 00 00 00 00 00 [C1]
[FC 62 01 30 10] A9 1C E0 AB EF 00 00 AD B3 00 07 00 00 00 00 00 [B7]
[FC 62 01 30 10] A9 1C E0 AB F8 00 00 AD B3 00 07 00 00 00 00 00 [AE]
[FC 62 01 30 10] A9 1C E0 AC 06 00 00 AD B3 00 07 00 00 00 00 00 [9F]
[FC 62 01 30 10] A9 1C E0 AC 0F 00 00 AD B3 00 07 00 00 00 00 00 [96]
[FC 62 01 30 10] A9 1C E0 AC 19 00 00 AD B3 00 07 00 00 00 00 00 [8C]

[FC 62 01 30 10] a9 1c e1 1b ad 00 01 a4 ad 00 07 00 00 00 00 00 [96]
```
