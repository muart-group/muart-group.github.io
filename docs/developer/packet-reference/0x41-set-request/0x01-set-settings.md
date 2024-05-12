# Command `0x01`: Set Settings

This command is used to issue a new operation state to the heat pump. It controls core behaviors like power, mode, 
target temperature, and similar.

| Byte | Purpose                   | Possible Values                                                                                                                     | Supported by mUART | Notes                                                          |
|------|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------|--------------------|----------------------------------------------------------------|
| 0    | Command Type              | 0x01                                                                                                                                | Yes                |
| 1-2  | Update Flags              | Traditional hex flags                                                                                                               | Partially          | Indicates which parameters to update.                          |
| 3    | Power                     | 0x00: Off<br/>0x01: On<br/>0x02: Test Mode                                                                                          | No                 | Update flag 0x0001                                             |
| 4    | Operating Mode            | See below                                                                                                                           | No                 | Update flag 0x0002                                             |
| 5    | Legacy Target Temperature | See [[Temperature Units\|Special Data Types#Temperature Units]]                                                                     |                    | Update flag 0x0004                                             |
| 6    | Fan                       | See below                                                                                                                           |                    | Update flag 0x0008<br/>Not all values supported for all units. |
| 7    | Vertical Vane             | 0x00: Auto<br/>0x01 - 0x05: Position X<br/>0x07: Swing                                                                              |                    | Update flag 0x0010<br/>Defaults to 0x5 on air handlers (?)     |
| 8    |
| 9    |
| 10   |
| 11   | Prohibit Flags            | See below                                                                                                                           |                    | Update Flag 0x0040                                             |
| 12   |
| 13   | Horizontal Vane           | 0x00: Auto<br/>0x01: Full Left<br/>0x02: Left<br/>0x03: Center<br/>0x04: Right<br/>0x05: Full Right<br/>0x08: Split<br/>0x0C: Swing |                    | Update Flag 0x0100                                             |
| 14   | Target Temperature        | Varies<br/>See [[Temperature Units\|Special Data Types#Temperature Units]]                                                          |                    | Update Flag 0x0004.<br/>Takes priority over legacy temperature |
| 15   |

### Sample Packets

```
[FC.41.01.30.10] 01.07.00.01.01.00.FF.01.00.00.00.00.00.00.AE.00 C6
```

## Operating Modes

| Value | Name       | Notes                                            |
|-------|------------|--------------------------------------------------|
| 1     | Heat       |                                                  |
| 2     | Dehumidify |                                                  |
| 3     | Cool       |                                                  |
| 7     | Fan        |                                                  |
| 8     | Auto       | Chooses mode based on current temp and setpoint. |
| 9     | i-see Heat | Cannot be set                                    |
| 10    | i-see Dry  | Cannot be set                                    |
| 11    | i-see Cool | Cannot be set                                    |
| 33    | Auto Heat  | Cannot be set, Kumo only?                        |
| 35    | Auto Cool  | Cannot be set, Kumo only?                        |

Operating mode 8 will use the current temperature of the room as well as the current setpoint to determine whether to
heat or cool. Mode 8 will be returned regardless of the status of the i-see feature.

:::warning
As of the time of writing this documentation, mode 8 will not work with MHK2 units. The MHK2 will intercept the request
for auto mode and configure its own dual-setpoint behavior.
:::

Operating modes 9-11 are read-only, and will only be returned by the heat pump when i-see mode is enabled. If i-see mode
is disabled, the unit will return the normal value.

## Fan Modes

Supported fan modes can be extracted from the Extended Connect Response packet.

| Value | Name                 |
|-------|----------------------|
| 0     | Auto                 |
| 1     | Quiet                |
| 2     | Low                  |
| 3     | Medium               |
| 5     | High                 |
| 6     | Very High (Powerful) |

## Prohibit Flags

The exact intent of this byte is unknown, but it appears to prevent certain changes from being made so long as the
prohibit flags are in place.


| Bit  | Purpose             | Supported by mUART | Notes |
|------|---------------------|--------------------|-------|
| 0x01 | Lock Power          |                    |       |
| 0x02 | Lock Operating Mode |                    |       |
| 0x04 | Lock Temperature    |                    |       |