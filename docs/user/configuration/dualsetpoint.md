# Dual Setpoint

Currently, due to limitations with how ESPHome handles dual setpoint components, it's not feasible to implement the MITP climate component as dual setpoint.  However, the ESPHome [thermostat](https://esphome.io/components/climate/thermostat) component can provide a dual setpoint wrapper.

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
- Using `supplemental_*_action`s to change the fan speed if additional circulation is needed.
- Adjusting deadband and overrun settings.  Because the heatpump will use its internal settings by default, some clever changes will be needed to fool the heat pump.  For example, to change `heat_overrun` the `heat_action` will need to set the actual hardware setpoint *above* the real target temperature so that the heat pump will continue to heat until this thermostat calls for idle.  This also means that `idle_action` will need to be filled out appropriately.

