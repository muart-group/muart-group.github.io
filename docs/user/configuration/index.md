# ESPHome Configuration

## Configuration Reference

The mUART component extends the [ESPHome Climate](https://esphome.io/components/climate/index.html) entity, so all
settings available in that are also available here.

### `update_interval`

The `update_interval` key controls how often the component will request status updates from the heat pump. As the 
communication is slow, it's recommended to keep this at no less than 5 seconds. Setting this value too high may prevent
ESPHome or Home Assistant from displaying updates performed via remote or thermostat in a timely manner.

```yaml
mitsubishi_uart:
  heatpump_uart: hp_uart
  # ...
  update_interval: 10s
```

### `temperature_sources`

This key takes an array of ESPHome sensor IDs to use as extra temperature sources. See the documentation page on
[adding extra temperature sources](temp-sources.md) for additional information.

### `thermostat_uart`

This key takes an ID of a UART component hosting a MHK2 thermoststat. See the documentation page on 
[adding a Mitsubishi thermostat](thermostat.md) for extra information.

### `supported_modes`

This key takes an array of supported operating modes. This can be used to hide certain modes (e.g. `Dry`) that a given
unit may not support. Leave this key un-set to use the default modes. Adding new modes will not have any effect, as the
code is not aware of them.

```yml
mitsubishi_uart:
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
mitsubishi_uart:
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

### Entity Fields

mUART also supports setting configurations for the co-exposed `sensors`, `selects`, `buttons`, and similar. These 
normally do not need to be changed, but exist for cases where overrides are necessary.

```yml
mitsubishi_uart:
  # ...
  sensors:
    current_temperature:
      # ...
  selects:
    temperature_source_select:
      # ...
```

A list of entity IDs is available [on the Entities documentation page](../entities.md).

## Showing Hidden Entities

Not all entities exposed by the mUART component actually report properly for all heat pumps. This may lead to UI bloat
in some cases, so many sensors, selects, and similar are `disabled_by_default`.

To show these entities, they can be manually enabled in Home Assistant. Alternatively, the ESPHome configuration can be
manually updated to set `disabled_by_default` to be false for that entity.