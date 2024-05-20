# Command `0x07` - Set Remote Temperature

This command is normally issued by a MHK thermostat and sent to the heat pump to control the room temperature.

| Byte | Purpose                     | Possible Values                                | Supported by mUART | Notes |
|------|-----------------------------|------------------------------------------------|--------------------|-------|
| 0    | Command Type                | 0x07                                           | Yes                |       |
| 1    | Flags                       | 0x00 Use Internal<br/>0x01 Remote Temp         | Yes                |
| 2    | Remote Temperature          | See [Legacy Current Temperatures][legacy-temp] | Yes                |
| 3    | Extended Remote Temperature | See [Enhanced Temperatures][enhanced-temp]     | Yes                |

When decoding this value, byte 3 takes precedence over byte 2. When sending this packet, it appears to be safe to just
send byte 3 though be aware that this may cause an issue with older units.

[legacy-temp]: ../../data-types/temperature-units.md#legacy-current-temperatures
[enhanced-temp]: ../../data-types/temperature-units.md#enhanced-temperatures