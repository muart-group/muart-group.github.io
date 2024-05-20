---
sidebar_position: 30
---

# mUART Exposed Entities

The following entities are exposed by the mUART Component:

| Type   | ID                                | Purpose                                                                     |
|--------|-----------------------------------|-----------------------------------------------------------------------------|
| Sensor | `thermostat_temperature`          | The current temperature reported by a connected MHK2.                       |
| Sensor | `error_code`                      | An error code (if any) reported by the unit, in human-friendly notation.    | 
| Sensor | `compressor_frequency`            | The compressor frequency of the outdoor unit. Not supported on all systems. |
| Sensor | `actual_fan`                      | The true fan speed reported by the heat pump.                               |
| Sensor | `service_filter`                  | A binary sensor indicating when the filter needs to be replaced.            |
| Sensor | `defrost`                         | A binary sensor indicating the outdoor unit is defrosting.                  |
| Sensor | `hot_adjust`                      | A binary sensor indicating the refrigerant loop is pre-heating.             |
| Sensor | `standby`                         | A binary sensor indicating that the heat pump is in standby.                |
| Select | `temperature_source_select`       | The currently active room temperature source reported to the heat pump.     |
| Select | `vane_position_select`            | The position of the vertical vane on the heat pump.                         |
| Select | `horizontal_vane_position_select` | The position of the horizontal vane on the heat pump.                       |

Note that not all sensors may report (usable) data on all hardware configurations. As a result, most of these entities 
will be `disabled_by_default`.