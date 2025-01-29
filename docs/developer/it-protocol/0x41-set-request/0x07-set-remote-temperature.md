# Command `0x07` - Set Remote Temperature

This command is normally issued by a MHK thermostat and sent to the heat pump to control the room temperature.

| Byte | Purpose                     | Possible Values                           | Supported by mUART | Notes |
|------|-----------------------------|-------------------------------------------|--------------------|-------|
| 0    | Command Type                | 0x07                                      | Yes                |       |
| 1    | Flags                       | 0x00 Use Internal<br/>0x01 Remote Temp    | Yes                |
| 2    | Remote Temperature          | [Legacy TS Room Temperature][legacy-temp] | Yes                |
| 3    | Remote Temperature          | [Enhanced Temperature][temp-a]            | Yes                |

When decoding this value, byte 3 will take precedence over byte 2.

Most thermostats (especially the MHK2) appear to not include the legacy room temperature, with seemingly no impact to
heat pump functionality. This was not fully tested on older units without awareness of the new Enhanced Temperature 
scale. It's generally advised to include both the legacy and enhanced values.

Certain thermostats (or units) may also possibly expect byte 2 to contain a value in the 
[HP Room Temperature][legacy-temp-hp] format, though this hasn't been strongly confirmed yet.

[legacy-temp]: ../data-types/temperature-units.md#thermostat-room-temperature
[legacy-temp-hp]: ../data-types/temperature-units.md#heat-pump-room-temperatures
[temp-a]: ../data-types/temperature-units.md#enhanced-temperatures