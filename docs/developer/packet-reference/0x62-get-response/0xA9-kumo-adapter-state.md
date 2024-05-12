# Command `0xA9` - Kumo Adapter State

Requested by thermostat in a 0x42 packet, response from Kumo in 0x62.

:::warning
The below table is speculative and not confirmed.

Implementations should not use these definitions until they've been verified more closely.
:::

| Byte | Purpose            | Possible Values                                   | Supported by mUART | Notes |
|------|--------------------|---------------------------------------------------|--------------------|-------|
| 0    | CommandType        | 0xA9                                              |                    |       |
| 1-4  | Adapter Timestamp  | See [[Timestamps\|Special Data Types#Timestamps]] |                    |       |
| 5    | ???                | 0x00                                              |                    |       |
| 6    | ???                | 0x00, 0x01                                        |                    |       |
| 7    | Auto Heat Setpoint | Enhanced Temperature                              | No                 |       |
| 8    | Auto Cool Setpoint | Enhanced Temperature                              | No                 |       |
| 10   | ???                | 0x00, 0x07                                        |                    |       |
| 12   | ???                | 0x00                                              |                    |       |


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
