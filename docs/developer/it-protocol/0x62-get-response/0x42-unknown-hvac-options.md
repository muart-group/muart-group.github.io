# Command `0x42` - HVAC Options

These options are extracted from an MSZ-AY HVAC device.

Returns the boolean whether the option is currently active or not.

It cannot be set with the [`0x41` - Set Request](../0x41-set-request).

| Byte | Purpose           | Possible Values     | Notes                                    |
|------|-------------------|---------------------|------------------------------------------|
| 0    | Command Type      | 0x42                |                                          |
| 1    | Air Purifier      | 0x00 or 0x01        | Plasma Quad filter active or not         |
| 2    | Night Mode        | 0x00 or 0x01        | Dims the LED status                      |


### Sample Packets

```
[FC.62.01.30.10] 42.01.00.00.00.00.00.00.00.00.00.00.00.00.00.00 1A  // MSZ-AY35VGKP
```