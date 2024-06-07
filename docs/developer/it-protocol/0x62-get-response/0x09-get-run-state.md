# Command `0x09` - Get Run Status


This command returns information about the heat pump's current run status. It is unclear if this is called as part of 
normal operation.

:::info
Certain older heat pump units do not return Run Status as part of their operation. So far, this has been reported on
the MSZ-GE##VA and MSZ-FD##VA units, but otherse may be affected.
:::

| Byte | Purpose          | Possible Values                         | Supported by mUART | Notes                                                                                     |
|------|------------------|-----------------------------------------|--------------------|-------------------------------------------------------------------------------------------|
| 0    | CommandType      | 0x09                                    |                    |
| 3    | Status Flags     | [Status Flags](#status-flags)           |                    | A bitmask of flags indicating the heat pump's current status.                             |
| 4    | Actual Fan Speed | [Actual Fan Speeds](#actual-fan-speeds) |                    | The speed the fan is currently operating at (may be different from fan setting in `0x02`) |
| 5    | Auto Mode?       | [Auto Mode](#auto-modes)                | No                 | Per swicago lib, idle mode but has other values.                                          |

### Example Packets

```
[FC.62.01.30.10]09.00.00.00.02.40.00.00.00.00.00.00.00.00.00.00 12  // wall unit heat request
[FC.62.01.30.10]09.00.00.00.01.40.00.00.00.00.00.00.00.00.00.00 13  // wall unit in idle
[FC.62.01.30.10]09.00.00.00.01.41.00.00.00.00.00.00.00.00.00.00 12  // wall unit in auto, idling
[FC.62.01.30.10]09.00.00.00.01.42.00.00.00.00.00.00.00.00.00.00 12  // wall unit in auto, heating
```

## Status Flags

| Bit  | Purpose   | Supported by mUART | Notes                                                                                      |
|------|-----------|--------------------|--------------------------------------------------------------------------------------------|
| 0x01 | Filter    |                    | The filter needs to be serviced.                                                           |
| 0x02 | Defrost   |                    | The outdoor unit is in a defrost cycle.                                                    |
| 0x04 | HotAdjust |                    | The system is preheating for a HEAT call.                                                  |
| 0x08 | Standby   |                    | The unit is in standby mode (another unit with priority is requesting a conflicting mode). |

## Actual Fan Speeds

These were extracted from Kumo UI, and don't particularly make much sense. It's unclear if "Super Quiet" is below or 
above "Very Low", for example. It's also unclear how these map to setting fan speeds (though a preliminary mapping is 
below). Active research about these values is currently being tracked as part of 
[Issue #27](https://github.com/Sammy1Am/mitsubishi-uart/issues/27)).

| Value | Name           | Related Set Speed |
|-------|----------------|-------------------|
| 0     | Off            | Off               |
| 1     | Very Low       | Not observed      |
| 2     | Quiet          | Low               |
| 3     | Low            | Medium            |
| 4     | Powerful       | High              |
| 5     | Super Powerful | Powerful          |
| 6     | Super Quiet    | Quiet             |

## Auto Modes

| Value | Name |
|-------|------|
| 0x00  | N/A  |
| 0x01  | Cool |
| 0x02  | Heat |
| 0x41  | ???  |
| 0x42  | ???  |
