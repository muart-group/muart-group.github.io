# Supported Sub-components

Sensors, buttons, and select menus can be added to the configuration for additonal functionality.  This page lists the available components with example configuration.

## Sensors

Sensors provide additional information from the equipment.  Not all sensors are available on all systems; see [sensor notes](#sensor-notes) for additional information.  

```yml
binary_sensor:
  - platform: mitsubishi_itp
    defrost:
      # Reports if system is in defrost
      name: "Defost"
    filter_status:
      # Reports if filter needs to be replaced (false = OK)
      name: "Filter Status"
    isee_status:
      # Reports if i-see is enabled
      name: "i-see Status"
    preheat:
      # Reports if system is preheating
      name: "Preheat"
    standby:
      # Reports if system is in standby
      name: "Standby"

sensor:
  - platform: mitsubishi_itp
    compressor_frequency:
      # Frequency in Hz of compressor (only some equipment)
      name: "Compressor Frequency"
    outdoor_temperature:
      # Outdoor temperature as reported by equipment
      name: "Outdoor Temperature"

    # Only available if a thermostat is connected
    thermostat_humidity:
      # Humidity reported by thermostat (only with enhanced_mhk)
      name: "Thermostat Humidity"
    thermostat_temperature:
      # Temperature reported by thermostat
      name: "Thermostat Temperature"

text_sensor:
  - platform: mitsubishi_itp
    actual_fan:
      # Actual current fan speed (vs. set speed)
      name: "Actual Fan"
    error_code:
      # Reports diagnostic error code
      name: "Error Code"

    # Only available if a thermostat is connected
    thermostat_battery:
      # Thermostat battery status (only with enhanced_mhk)
      name: "Thermostat Battery"
```

## Sensor Notes

### outdoor_temperature
The `outdoor_temperature` sensor seems to provide values inconsistently.  It's possible that the byte containing the value has a flag in it, and it seems like the temperature is only reported under certain conditions.


### actual_fan
While the unit is preheating or at set-point, sometimes the fan will be running at a speed other than the requested one; this sensor reports that "actual" speed.

## Buttons
A button can be added to reset the filter change status:

```yml
button:
- platform: mitsubishi_itp
  filter_reset_button:
    name: "Filter Reset"
```
## Selects

### Vane Control

On units with vertical or horizontal vane control, the following components can be added to the configuration to enable control.
```yml
select:
  - platform: mitsubishi_itp
    vane_position:
      name: "Vane Position"
    horizontal_vane_position:
      name: "H. Vane Position"
```
### Temperature Source Select

See [adding extra temperature sources](temp-sources.md).