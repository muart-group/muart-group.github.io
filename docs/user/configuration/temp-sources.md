# Adding Extra Temperature Sources

It's possible to add additional sensors as temperature sources. The `temperature_source` select component has a variable `sources` that takes a list of IDs defined in the ESPHome configuration. Note that all sensors must return values in **degrees Celsius** - conversion may be necessary for some sensors.

:::tip
If an MHK2 is connected [and configured](thermostat.md), it will automatically add itself as a valid temperature source.
:::

:::note
If an update from the sensor is not received after 7 min, the component will switch back to using the heat pump's 
internal temperature sensor. Ensure any sensors report at least every 7 minutes.

The heat pump itself will revert back to the internal sensor after approximately 10 minutes without an update, and this
component enforces that check.
:::

```yml
sensor:
  - platform: homeassistant
    id: office_temperature
    name: "Office Temperature Sensor"
    entity_id: sensor.office_air_temperature
    filters:
      - lambda: return ((x - 32.0) * (5.0 / 9.0));  # Remember to convert F to C!

select:
  - platform: mitsubishi_itp
    temperature_source:
      name: "Temperature Source"
      sources:
        - office_temperature

climate:
  - platform: mitsubishi_itp
    name: "Climate"
    uart_heatpump: hp_uart
    # ...
```

The sensor name as defined in ESPHome will also display in the Home Assistant UI for the temperature selector.