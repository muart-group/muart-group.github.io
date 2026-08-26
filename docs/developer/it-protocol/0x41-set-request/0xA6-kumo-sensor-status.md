# Command `0xA6` - Kumo Sensor Status

Sent from the MHK2 to a Kumo Cloud unit, captured via logic analyzer. Only sent under certain conditions, though it is
currently unclear what those are.

:::note
The information about this packet is speculative at the moment and should not be used for active implementations. If you
have any extra sensor hardware, please reach out or add your packets so that we can investigate further!
:::

| Byte | Purpose                          | Possible Values  | Supported by mUART | Notes         |
|------|----------------------------------|------------------|--------------------|---------------|
| 0    | Command Type                     | 0xA6             | No                 |               |
| 1    | Flags?                           | 1C               |                    |               |
| 2-3  | Outdoor Temperature (?)          | 0x00             |                    | Flag 0x01 (?) |
| 4    | % Outdoor Relative Humidity (?)  | 00               |                    | Flag 0x02 (?) |
| 5    | % Indoor Relative Humidity       | 0x00 to 0x64 (?) | No                 | Flag 0x04     |
| 6    | MHK2 Battery State               | 0x00 to 0x04     | No                 | Flag 0x08     |
| 7    | Connected Sensor Flags           | See below        |                    | Flag 0x10     |
| 8    | Indoor Sensor Battery State (?)  | 0x00 to 0x04     |                    | Flag 0x20     |
| 9    | Outdoor Sensor Battery State (?) | 0x00 to 0x04     |                    | Flag 0x40     |

### Sample Packets

```
[FC.41.01.30.10] A6.1C.00.00.00.34.00.01.00.00.00.00.00.00.00.00 [87]  // captured twice with logic analyzer 
[FC.41.01.30.10] A6.1C.00.00.00.30.00.01.00.00.00.00.00.00.00.00 [8B]

[FC.41.01.30.10] A6.1C.00.00.00.28.00.05.00.00.00.00.00.00.00.00 [8F] // with IAS connected
```

## Battery States

| Value | Meaning  |
|-------|----------|
| 0x0   | OK       |
| 0x1   | Low      |
| 0x2   | Critical |
| 0x3   | Replace  |
| 0x4   | Unknown  |

## Device Flags

Extracted from firmware, but the outdoor sensor (MOS1) was not confirmed due to a lack of hardware.

| Flag | Device         | Known Models             | 
|------|----------------|--------------------------|
| 0x01 | Thermostat     | [MHK2][mhk2]/MHK1 (?)    |
| 0x02 | Outdoor Sensor | Unknown, possibly MOS1?  |
| 0x04 | Indoor Sensor  | [RCHTSENSOR][rcht]       |

[mhk2]: https://mylinkdrive.com/USA/Controls/MHK2?product&categoryName=Controls
[rcht]: https://www.honeywellstore.com/store/products/honeywell-smart-room-sensor-for-t9t10-thermostats-rchtsensor-1pk.htm

## Outdoor Temperature Reporting

This decoder was extracted from firmware, and not yet verified against a real unit.

Special error codes are communicated using the top three bits, which take precedence over a reading:

| Flag   | Error Code | Description          |
|--------|------------|----------------------|
| 0x8000 | 3          | Device Not Connected |
| 0x4000 | 1          | Invalid Data (?)     |
| 0x2000 | 2          | Invalid Data (?)     |

Assuming no error is reported, temperature can be recovered via `((raw & 0x1FFF) / 10.0 - 100.0`. Temperatures
have a 0.1°C precision, with a range starting at -100.0°C.
