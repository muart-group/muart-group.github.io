# Command `0xD0`: Unknown Identify Packet

:::note
This command ID was extracted from the 霧ヶ峰REMOTE (Kirigamine REMOTE) Android application
(v5.3.1), which contains a `parseD0Value` handler alongside handlers for `0x02`, `0x03`,
`0x04`, `0x05`, `0x09`, `0xC9` and `0xCD`.

The bit meanings below are the app's own capability flag names. No response to this command
has been captured yet, so the layout is **unverified against a real unit** — it may be
region- or generation-specific.
:::

| Byte | Purpose           | Possible Values | Supported by mUART | Notes |
|------|-------------------|-----------------|--------------------|-------|
| 0    | CommandType       | 0xD0            |                    |       |
| 1-15 | Unknown           |                 |                    | See below |

## Unit Capabilities (per 霧ヶ峰REMOTE v5.3.1)

| Byte | Bitmask | App flag                     | Notes                                                                 |
|------|---------|------------------------------|-----------------------------------------------------------------------|
| 1    | 0x10    | `isSupportVitalSensorControl`| True only when `0x10` set **and** `0x20` and `0x40` both clear.       |
| 1    | 0x20    | (part of above test)         |                                                                       |
| 1    | 0x40    | (part of above test)         |                                                                       |
| 2    | 0x01    | `isThermalSensorSupport`     |                                                                       |
| 2    | 0x04    | `isSupportWindDirectionSpeed`| Support is true if **any** of `0x04`, `0x08`, `0x20` is set.          |
| 2    | 0x08    | `isSupportWindDirectionSpeed`|                                                                       |
| 2    | 0x20    | `isDisplayWindLeftRight`     | Left/right (wide) vane control. Also feeds the flag above.            |
| 2    | 0x40    | `isDisplayLong`              |                                                                       |
| 2    | 0x80    | `isDisplayWindAndWindBreak`  |                                                                       |

## Units Known Not To Respond

| Model      | Notes                                                                 |
|------------|-------------------------------------------------------------------------|
| MLZ-KP18NA | 1-way ceiling cassette, NA market, 2018 design. No response to `0xD0`. |
