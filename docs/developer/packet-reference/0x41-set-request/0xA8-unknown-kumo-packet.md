# Command `0xA8` - MHK2 State Update

This command appears to be intended to synchronize the MHK2's state to the Kumo Cloud. It is sent on a regular cadence by
the MHK2 if an upstream Kumo device has been detected.

| Byte | Purpose                | Possible Values                   | Supported by mUART | Notes                               |
|------|------------------------|-----------------------------------|--------------------|-------------------------------------|
| 0    | Command Type           | 0xA8                              | Partial            |                                     |
| 1    | Flags                  | Traditional hex flags             |                    | Determines which fields to process  |
| 2-5  | Thermostat Time (?)    | See [Timestamps][timestamp]       |                    | Flag 0x01                           |
| 6    | ???                    | 0x00, 0x01                        |                    | Flag 0x02                           |
| 7    | ???                    | 0x00, 0x01, 0x02                  |                    | Flag 0x04                           |
| 8    | Heating Setpoint       | See [Enhanced Temperatures][temp] |                    | Flag 0x08<br/>Resets if invalid (?) |
| 9    | Cooling Setpoint       | See [Enhanced Temperatures][temp] |                    | Flag 0x10<br/>Resets if invalid (?) |
| 10   | ???                    | 0x00, 0x01                        |                    | Flag 0x20                           |
| 11   | ???                    | 0x00, 0x01                        |                    | Flag 0x40                           |

[timestamp]: ../../data-types/timestamps.md
[temp]: ../../data-types/temperature-units.md#enhanced-temperatures

## Temperature Setpoints

The MHK2 only has two temperature setpoints *total*: one for heating and one for cooling. Changing either of these setpoints
in auto mode or in heat-only/cool-only mode will also update the setpoints in these fields.

In order to update the unit setpoints for heating and cooling mode while a Kumo is connected (or a Kumo is being emulated), the
setpoints must be sent via packet A9. Otherwise, the MHK will detect a desync on its next receipt of a Get Settings and attempt
to issue a correction.

## Sample Packets

```
[FC 41 01 30 10] A8 01 1C DD 51 F3 00 00 00 00 00 00 00 00 00 00 [98]
[FC 41 01 30 10] A8 18 00 00 00 00 00 00 AD B3 00 00 00 00 00 00 [5E]
```
