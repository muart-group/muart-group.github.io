---
sidebar_position: 30
---

# mUART Exposed Entities

The following entities are exposed by the mUART Component:

| Type   | ID                                | Purpose                                                                            |
|--------|-----------------------------------|------------------------------------------------------------------------------------|
| Sensor        | `thermostat_temperature`          | The current temperature reported by a connected MHK2.                       |
| Text Sensor   | `error_code`                      | An error code (if any) reported by the unit, in human-friendly notation.    | 
| Sensor        | `compressor_frequency`            | The compressor frequency of the outdoor unit. Not supported on all systems. |
| Sensor        | `outdoor_temperature`             | On some systems, the temperature reported by the outdoor unit.              |
| Text Sensor   | `actual_fan`                      | The true fan speed reported by the heat pump.                               |
| Binary Sensor | `service_filter`                  | A binary sensor indicating when the filter needs to be replaced.            |
| Binary Sensor | `defrost`                         | A binary sensor indicating the outdoor unit is defrosting.                  |
| Binary Sensor | `preheat`                         | A binary sensor indicating the refrigerant loop is pre-heating.             |
| Binary Sensor | `standby`                         | A binary sensor indicating that the heat pump is in standby.                |
| Select        | `temperature_source_select`       | The currently active room temperature source reported to the heat pump.     |
| Select        | `vane_position_select`            | The position of the vertical vane on the heat pump.                         |
| Select        | `horizontal_vane_position_select` | The position of the horizontal vane on the heat pump.                       |

Note that these sensors are not enabled by default and must be explicitly added by the user (see [supported sub-components](./configuration/subcomponents.md) for more).