# ESPHome Configuration

## Configuration Reference

The mUART component extends the [ESPHome Climate](https://esphome.io/components/climate/index.html) entity, so all
settings available in that are also available here.

### `update_interval`

The `update_interval` key controls how often the component will request status updates from the heat pump. As the 
communication is slow, it's recommended to keep this at no less than 5 seconds. Setting this value too high may prevent
ESPHome or Home Assistant from displaying updates performed via remote or thermostat in a timely manner.

```yaml
climate:
  - platform: mitsubishi_itp
    name: "Climate"
    uart_heatpump: hp_uart
    # ...
    update_interval: 10s
```

### `uart_thermostat`

This key takes an ID of a UART component hosting a MHK2 thermoststat. See the documentation page on 
[adding a Mitsubishi thermostat](thermostat.md) for extra information.

### `supported_modes`

This key takes an array of supported operating modes. This can be used to hide certain modes (e.g. `Dry`) that a given
unit may not support. Leave this key un-set to use the default modes. Adding new modes will not have any effect, as the
code is not aware of them.

```yml
climate:
  - platform: mitsubishi_itp
    # ...
    supported_modes:
      - 'OFF'
      - HEAT
      - DRY
      - COOL
      - FAN_ONLY
      - HEAT_COOL
```

### `supported_fan_modes` and `custom_fan_modes`

These keys allow removing fan modes not supported by the unit. Leave this key un-set to use the default modes. Adding 
new modes will not have any effect, as the code is not aware of them.

```yml
climate:
  - platform: mitsubishi_itp
    # ...
    supported_fan_modes:
      - AUTO
      - QUIET
      - LOW
      - MEDIUM
      - HIGH
    custom_fan_modes:
      - VERYHIGH
```

The `custom_fan_modes` key is used to include the `VERYHIGH` (otherwise known as **Powerful**) state, which is not
natively supported by ESPHome or Home Assistant.

Sub-components (like sensors) need to be explictly added to the configuration.  Additional information is available [on the Sub-Components documentation page](./subcomponents.md).