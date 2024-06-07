# Command `0xC9`: Base Capabilities

This command is used to retrieve base capability information from a heat pump. This command response is used to check
whether certain features exist on any given unit, and is used to self-configure units accordingly.

| Byte | Purpose           | Possible Values | Supported by mUART | Notes |
|------|-------------------|-----------------|--------------------|-------|
| 0    | CommandType       | 0xC9            |                    |       |
| 1-6  | "Arbitrary Data"  | 0x03            |                    |       |
| 7-15 | Unit Capabilities | See below       |                    |       |

## Unit Capabilities

| Byte | Bitmask | Purpose                                | Notes                                                      |
|------|---------|----------------------------------------|------------------------------------------------------------|
| 7    | 0x01    | ???                                    | Observed true                                              |
| 7    | 0x02    | Heat Disabled (if true)                |                                                            |
| 7    | 0x04    | ???                                    | Observed true                                              |
| 7    | 0x08    | ???                                    |                                                            |
| 7    | 0x10    | Fan Bit A                              |                                                            |
| 7    | 0x20    | Vertical Vane support                  |                                                            |
| 7    | 0x40    | Vane swing support                     | Seems to cover both vane types, if horizontal vane exists. |
| 7    | 0x80    | ???                                    |                                                            |
| 8    | 0x01    | Dry function disabled (if true)        |                                                            |
| 8    | 0x02    | Fan function disabled (if true)        |                                                            |
| 8    | 0x04    | Has extended temperature range         | Seems to determine if the A-scale is usable.               |
| 8    | 0x08    | Fan Bit B                              |                                                            |
| 8    | 0x10    | Automatic Fan Speed disabled (if true) |                                                            |
| 8    | 0x20    | Installer Settings (Function) support  |                                                            |
| 8    | 0x40    | Test Mode support                      |                                                            |
| 8    | 0x80    | Supports dry temperature               |                                                            |
| 9    | 0x01    | Has status display                     |                                                            |
| 9    | 0x02    | Fan Bit C                              |                                                            |
| 9    | 0x04    | ???                                    | Observed true and false                                    |
| 9    | 0x08    | ???                                    |                                                            |
| 9    | 0x10    | ???                                    | Observed true and false                                    |
| 9    | 0x20    | Supports Outside Temp Reporting        | Unconfirmed, possibly JP units only.                       |
| 9    | 0x40    | ???                                    |                                                            |
| 9    | 0x80    | ???                                    | Observed true and false                                    |
| 10   | All     | Minimum cool/dry temp setpoint         |                                                            |
| 11   | All     | Maximum cool/dry temp setpoint         |                                                            |
| 12   | All     | Minimum heating temp setpoint          |                                                            |
| 13   | All     | Maximum heating temp setpoint          |                                                            |
| 14   | All     | Minimum auto temp setpoint             |                                                            |
| 15   | All     | Maximum auto temp setpoint             |                                                            |

Bytes 10-15 appear to only be sent if the extended temperature range is supported by the unit.

## Determining Fan Speeds

The number of allowed fan speeds is determined by fan bits A, B, and C, as calculated below:

```python
def get_fan_speeds(capabilities: list[int]):
    fan_speed_lut = { 1: 1, 2: 2, 0: 3, 4: 4, 6: 5 }
    
    raw_speed = ((capabilities[0] & 0x10) >> 2) + \
                ((capabilities[1] & 0x08) >> 2) + \
                ((capabilities[2] & 0x02) >> 1)
    
    return fan_speed_lut[raw_speed]
```

The exact mapping as to fan speed names is currently unclear, though the below mapping seems reasonable:

```python3
{
    1: ["ON"],
    2: ["LOW", "HIGH"],
    3: ["LOW", "MEDIUM", "HIGH"],
    4: ["LOW", "MEDIUM", "HIGH", "VERY_HIGH"]
    5: ["VERY_LOW", "LOW", "MEDIUM", "HIGH", "VERY_HIGH"]
}
```

Note that these values *may not* correspond with the actual numbers provided to the fan system - verification will need to be done.

Known fan speed values (and model numbers associated with certain fan speed values) are below:

| Fan Speed Value | Model Numbers          | Supported Modes                                                                    |
|-----------------|------------------------|------------------------------------------------------------------------------------|
| 3               | SVZ-KP30NA             | 0x02 (Low)<br/>0x03 (Medium)<br/>0x05 (High)                                       |
| 5               | MSZ-GS12NA, MSZ-FS06NA | 0x01 (Quiet)<br/>0x02 (Low)<br/>0x03 (Medium)<br/>0x05 (High)<br/>0x06 (Very High) |

![image](https://github.com/Sammy1Am/mitsubishi-uart/assets/5192145/ffed7a33-2eb9-4d34-83e0-924df8ac5642)

## Sample Packets

```
[FC.7B.01.30.10] C9.03.00.20.00.0A.07.05.E4.25.A6.BC.94.B8.A6.B8 2D  // SVZ-KP30NA
[FC.7B.01.30.10] C9.03.00.20.00.14.07.75.8C.25.A0.BE.94.BE.A0.BE 09  // MSZ-GS12NA
[FC.7B.01.30.10] C9.03.00.20.00.14.07.75.0C.05.A0.BE.94.BE.A0.BE A9  // MSZ-GL06NA
[FC.7B.01.30.10] C9.03.00.09.04.14.07.75.00.00.00.00.00.00.00.00 DB  // MSZ-GE35VA
[FC.7B.01.30.10] C9.03.00.20.00.14.07.75.8C.25.A0.BE.94.BE.A0.BE 09  // MSZ-FS06NA
[FC.7B.01.30.10] C9.03.00.08.04.14.07.75.00.00.00.00.00.00.00.00 DC  // MSZ-FD25VA
```
