# Command `0x03` - Get Temperatures

This command is used to retrieve temperature information from the heat pump.

| Byte  | Purpose                    | Possible Values                           | Supported by mUART | Notes                                                                          |
|-------|----------------------------|-------------------------------------------|--------------------|--------------------------------------------------------------------------------|
| 0     | Command                    | 0x03                                      | Yes                |
| 3     | Current Legacy Temperature | [Legacy Current Temperature][legacy-temp] |                    |                                                                                |
| 5     | Outdoor Unit Temperature   | [Enhanced Temperature][temp-a]            |                    | Rounded to nearest whole °C<br/>If 0x00, unsupported.                          |
| 6     | Current Temperature        | [Enhanced Temperature][temp-a]            |                    |                                                                                |
| 7     | ???                        | [Enhanced Temperature][temp-a]            |                    | Claimed to be the most recent value, but observations do not match that.       |
| 8     | ???                        | 0x00, 0xFE                                |                    |                                                                                |
| 9     | ???                        | 0x42, 0x00                                |                    |                                                                                |
| 11-13 | Timestamp?                 | Scalar                                    |                    | Appears to be minutes since an unknown event.<br/>Not sent for all unit types. |

Bytes 6 and 7 are particularly confusing. First off, byte 7 is not sent by all units. SwiCago's thread has identified 
Byte 7 to be the "most recent" reading, while Byte 6 is the last reading. While this works for external temperature 
sensors, it does not work for the internal sensor - see below sample packet where it goes from 0xA9 to 0xAC and 
completely ignores the 0xB0. Kumo's code claims that byte 6 is `room_temp_a`, and does not use byte 7 at all.

The Outdoor Unit Temperature byte may not be present on all units, and appears to be controlled by the appropriate
flag (byte 9, bit 0x20) in the [capabilities response](../0x7B-identify-response/0xC9-base-capabilities.md). This
field appears to not necessarily be an accurate measure, as the heat pump's outdoor unit tends to cause local
temperature changes when it's operating. This field is not supported by all units. 

[legacy-temp]: ../data-types/temperature-units.md#legacy-current-temperatures
[temp-a]: ../data-types/temperature-units.md#enhanced-temperatures

### Sample Packets

```
[FC.62.01.30.10]03.00.00.0C.00.92.AC.00.00.00.00.00.00.00.00.00 10  // SVZ-KP30NA

[FC.62.01.30.10]03.00.00.0F.00.92.B2.B6.FE.42.00.01.59.7A.00.00 3D  // MSZ-GS12NA
[FC.62.01.30.10]03.00.00.09.00.92.A7.A7.FE.42.00.01.59.7B.00.00 5C
[FC.62.01.30.10]03.00.00.0A.00.8A.A9.A9.FE.42.00.01.5A.ED.00.00 EC
[FC.62.01.30.10]03.00.00.0C.00.88.AC.B0.FE.42.00.01.5A.FA.00.00 D5  // ... internal temp
[FC.62.01.30.10]03.00.00.0C.00.88.AC.A9.FE.42.00.01.5A.FB.00.00 DB  // back to external
[FC.62.01.30.10]03.00.00.0A.00.88.A9.A9.FE.42.00.01.5A.FB.00.00 E0 
[FC.62.01.30.10]03.00.00.0A.00.88.A9.B0.FE.42.00.01.5A.FC.00.00 D8  // back to internal
[FC.62.01.30.10]03.00.00.0C.00.88.AC.B0.FE.42.00.01.5A.FC.00.00 D3
```
