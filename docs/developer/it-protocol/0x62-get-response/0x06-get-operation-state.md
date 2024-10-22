# Command `0x06` - Get Operation State

:::note
This packet's information was pulled from [SwiCago's HeatPump](https://github.com/SwiCago/HeatPump/) library. It has 
not been observed over the wire without specifically requesting command `0x06`.
:::

This command returns diagnostic (?) information about the heat pump's operating state. This command does not appear to 
be used as part of normal heat pump operation.

| Byte | Purpose                    | Possible Values | Supported by mUART | Notes                                                                                    |
|------|----------------------------|-----------------|--------------------|------------------------------------------------------------------------------------------|
| 0    | CommandType                | 0x06            |                    |                                                                                          |
| 3    | CompressorFrequency        | Variable        | Yes                | The current compressor frequency in Hertz. Not supported/reported by all units.          |
| 4    | Operating                  | 0x00, 0x01      | Yes                | A boolean indicating whether the heat pump is operating.                                 |
| 5-6  | Input Power (Watts)        | Variable        | No                 | Reported by EChatvet's lib in watts. Unconfirmed, not supported by all units.            |
| 7-8  | Lifetime Power Consumption | Variable        | No                 | Reported by EChatvet's lib in 100Wh increments. Unconfirmed, not supported by all units. |
| 11   | ???                        | 0x00, 0x42      | No                 |                                                                                          |

### Sample Packets

```
[FC.62.01.30.10]06.00.00.00.01.00.00.00.00.00.00.00.00.00.00.00 56  // SVZ-KP30NA
[FC.62.01.30.10]06.00.00.00.00.00.00.00.78.00.00.42.00.00.00.00 9D  // MSZ-GS12NA
[FC.62.01.30.10]06.00.00.00.00.00.00.00.79.00.00.42.00.00.00.00 9C  // MSZ-GS12NA
```
