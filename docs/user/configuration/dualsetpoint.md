# Dual Setpoint

Dual Setpoint is now supported by default from `v2` of the MITP Component!

The climate component now uses `target_temperature_low` and `target_temperature_high` to track setpoint targets. A few notes:

- ESPHome / Home Assistant track both setpoints at all times, and HA will actually display both of them in modes other than HEAT or COOL (e.g. in OFF and FAN_ONLY both setpoints will still be displayed). The setpoints are persistent between mode changes, so changing the low setpoint while the system is OFF will still change the setpoint that gets used when the system is switched to HEAT for example.
- There is a 2°C minimum gap between setpoints to allow for a reasonable deadband in HEAT_COOL mode and prevent quick flip-flopping when switching between COOL and HEAT. If targets are set closer than this, the MITP Component will log a warning and adjust the setpoints to maintain the gap.
- The single-setpoint `target_temperature` is no longer used, though HA/ESPHome will sometimes still accept it and pass it along to one of the two other targets.

There are two logic modes for handling changeover in HEAT_COOL:

### With MHK2

The low and high setpoints will be passed to the MHK2, and the MHK2 set to "Auto" mode. The MITP Component will not automatically attempt any changeover and will allow the MHK2 to handle changeover. This is to prevent trying to change the mode at a time when the MHK2 would not and having it try to change it back.

### Without MHK2

The heat pump will be switched to COOL if the current temperature is equal to or greater than the high target; the heat pump will be switched to HEAT if the temperature is equal to or less than the low target. If the temperature is between the target points, the MITP Component will do its best to just leave the unit in whatever mode it is currently in (to avoid flip flopping)

----

## Thermostat Wrapper

Previously, before dual setpoint was supported, one solution was to use the ESPHome [thermostat](https://esphome.io/components/climate/thermostat) component to provide a dual setpoint wrapper. ℹ️ This is no longer required as dual setpoint is the default, however we're preserving this example for now because it may be useful for layering custom control logic on top of the existing climate controls (e.g. for creating a single setpoint wrapper).

Below is a snippet of configuration that will set up a rudimentary dual setpoint wrapper around a MITP climate component.  There are a lot of values here that could be adjusted to suit your needs, as well as a many more options documented for the [thermostat](https://esphome.io/components/climate/thermostat).

```yaml
sensor:
  - platform: template
    id: hp_current_temperature
    internal: true
    update_interval: 12s
    lambda: |-
      return id(main_climate).current_temperature;
climate:
  - platform: mitsubishi_itp
    name: "Climate"
    id: main_climate
		# internal: true # Uncomment this line to hide in Home Assistant
    uart_heatpump: hp_uart
  - platform: thermostat
    name: "Meta Climate"
    id: meta_climate
    visual:
      temperature_step:
        target_temperature: 0.5
        current_temperature: 0.1
    sensor: hp_current_temperature
    min_heating_off_time: 300s
    min_heating_run_time: 300s
		min_cooling_off_time: 300s
    min_cooling_run_time: 300s
    min_idle_time: 600s
    heat_action: 
      then:
        - climate.control: 
            id: main_climate
            mode: "HEAT"
            target_temperature: !lambda |-
              return id(meta_climate).target_temperature;
    cool_action: 
      then:
        - climate.control: 
            id: main_climate
            mode: "COOL"
            target_temperature: !lambda |-
              return id(meta_climate).target_temperature;
    idle_action: 
      then: #Not needed, the heat pump will idle on its own    
    target_temperature_change_action: 
      then:
        - climate.control: 
            id: main_climate
            target_temperature: !lambda |-
              return id(meta_climate).target_temperature;
    off_mode:
      then:
        - climate.control: 
            id: main_climate
            mode: "OFF"
```

The code above will result in *both* climate components being available to Home Assistant.  This can be useful to e.g. check on the true status of the heat pump behind the thermostat component, but could also be confusing.  If you don't need both, you can add `internal: true` to the MITP componet to hide it from Home Assistant.

Other potential uses for this wrapper include:

- Using the `idle_action` to control the fan speed when setpoint has been reached.
- Creating a single-setpoint wrapper that passes appropriate values to the underlying dual setpoints.
- Using `supplemental_*_action`s to change the fan speed if additional circulation is needed.
- Adjusting deadband and overrun settings.  Because the heatpump will use its internal settings by default, some clever changes will be needed to fool the heat pump.  For example, to change `heat_overrun` the `heat_action` will need to set the actual hardware setpoint *above* the real target temperature so that the heat pump will continue to heat until this thermostat calls for idle.  This also means that `idle_action` will need to be filled out appropriately.

