# Command `0x01` - Set Settings

This command is used to issue a new operation state to the heat pump. It controls core behaviors like power, mode,
target temperature, and similar.

| Byte | Purpose                   | Possible Values                                 | Supported by mUART | Notes                                                          |
|------|---------------------------|-------------------------------------------------|--------------------|----------------------------------------------------------------|
| 0    | Command Type              | 0x01                                            | Yes                |
| 1-2  | Update Flags              | Traditional hex flags                           | Partially          | Indicates which parameters to update.                          |
| 3    | Power                     | 0x00: Off<br/>0x01: On<br/>0x02: Test Mode      | No                 | Update flag 0x0001                                             |
| 4    | Operating Mode            | See [Operating Modes](#operating-modes)         | No                 | Update flag 0x0002                                             |
| 5    | Legacy Target Temperature | See [Legacy Setpoint Temperatures][legacy-temp] |                    | Update flag 0x0004                                             |
| 6    | Fan                       | See [Fan Modes](#fan-modes)                     |                    | Update flag 0x0008<br/>Not all values supported for all units. |
| 7    | Vertical Vane             | See [Vertical Vane](#vertical-vane)             |                    | Update flag 0x0010<br/>Defaults to 0x5 on air handlers (?)     |
| 8    |
| 9    |
| 10   |
| 11   | Prohibit Flags            | See [Prohibit Flags](#prohibit-flags)           |                    | Update Flag 0x0040                                             |
| 12   |
| 13   | Horizontal Vane           | See [Horizontal Vane](#horizontal-vane)         |                    | Update Flag 0x0100                                             |
| 14   | Target Temperature        | See [Enhanced Temperatures][enhanced-temp]      |                    | Update Flag 0x0004.<br/>Takes priority over legacy temperature |
| 15   |

[legacy-temp]: ../../data-types/temperature-units.md#legacy-setpoint-temperatures
[enhanced-temp]: ../../data-types/temperature-units.md#enhanced-temperatures

### Sample Packets

```
[FC.41.01.30.10] 01.07.00.01.01.00.FF.01.00.00.00.00.00.00.AE.00 C6
```

## Operating Modes

| Value | Name       | Settable | Notes                           |
|-------|------------|----------|---------------------------------|
| 1     | Heat       | Yes      |                                 |
| 2     | Dehumidify | Yes      |                                 |
| 3     | Cool       | Yes      |                                 |
| 7     | Fan        | Yes      |                                 |
| 8     | Auto       | Yes      |                                 |
| 9     | i-see Heat | No       |                                 |
| 10    | i-see Dry  | No       |                                 |
| 11    | i-see Cool | No       |                                 |
| 33    | Auto Heat  | No       | Only reported in Kumo Cloud API |
| 35    | Auto Cool  | No       | Only reported in Kumo Cloud API |

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

## Vertical Vane

| Value | Name             |
|-------|------------------|
| 0     | Auto Position    |
| 1     | Position 1 (0°)  |
| 2     | Position 2       |
| 3     | Position 3 (45°) |
| 4     | Position 4       |
| 5     | Position 5 (90°) |
| 7     | Swing Mode       |

If set on a dual vane unit, both the left and right vanes will update in sync. There is not currently a known way to
set each vane side independently.

## Prohibit Flags

The exact intent of this byte is unknown, but it appears to prevent certain changes from being made so long as the
prohibit flags are in place.

| Bit  | Purpose             | Supported by mUART | Notes |
|------|---------------------|--------------------|-------|
| 0x01 | Lock Power          |                    |       |
| 0x02 | Lock Operating Mode |                    |       |
| 0x04 | Lock Temperature    |                    |       |

## Horizontal Vane

| Value | Name                      | Symbol | Notes                        |
|-------|---------------------------|--------|------------------------------|
| 0     | Auto                      |        |                              |
| 1     | Full Left                 | `<<`   |                              |
| 2     | Left                      | `<`    |                              |
| 3     | Center                    | `\|`   |                              |
| 4     | Right                     | `>`    |                              |
| 5     | Full Right                | `>>`   |                              |
| 6     | Split (Left/Center)       |        | Unconfirmed, may be JP only. |
| 7     | Split (Center/Right)      |        | Unconfirmed, may be JP only. |
| 8     | Split (Left/Right)        | `<>`   |                              |
| 9     | Split (Left/Center/Right) |        | Unconfirmed, may be JP only. |
| 12    | Swing Mode                |        |                              |

Note that auto mode may not be supported on all units, and appears to get overwritten with relative frequency (but 
*does* appear to otherwise work).
