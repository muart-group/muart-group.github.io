# Dealing with Infrequent Sensor Updates

When using an external temperature sensor (like a thermostat or Home Assistant sensor), if the heat pump does not receive an update from the sensor in a certain amount of time (generally ranging from 1 to 10 minutes depending on the equipment) it will revert to using its internal temperature sensor. This can cause inconsistent behavior if e.g. the heat pump is in a cold basement, or the unit is mounted on the wall near the ceiling.

Ideally the external temperature sensors would provide updates frequently enough to avoid this timeout, but many sensors provide less frequent updates (especially battery powered sensors) or only publish a value when the temperature has changed.

There are multiple workarounds for this challege, but two recommended workarounds are presented below:

## Echo Configuration

In the ESPHome configuration for the `temperature_source` component, the `echo_interval` and `timeout` values can be set:
```yaml
select:
  - platform: mitsubishi_itp
    temperature_source:
      name: "Temperature Source"
      id: temp_source_select
      sources:
        - fake_temp
        - home_assistant_temperature
        - virtual_temp
      echo_interval: 5min
      timeout: 16min   
```
Setting `echo_interval` will cause the MITP component to echo the previous temperature reading to the heat pump at the specified interval. This interval should be shorter than the timeout on the heat pump equipment.

If no new input from the sensor has been received in `timeout`, the MITP component will explicitly fallback to the internal temperature sensor on the equipment. This is to prevent over-heating or over-cooling in the even that the sensor (or a dependency like Home Assisstant) becomes unavailable.

## Push Service

Creating a template sensor:
```yaml
sensor:
  - platform: template
    id: home_assistant_temperature
    internal: true
    name: "Home Assistant"
    update_interval: never
```
and a service:
```yaml
api:
  services:
    - service: report_temperature
      variables:
        current_temperature_C: float
      then:
        - sensor.template.publish:
            id: home_assistant_temperature
            state: !lambda "return current_temperature_C;"
```
will make the service available in Home Assistant where an automation can *push* temperature values to the MITP controller.

This not only allows a Home Assistant automation to replicate the echo functionality seen [above](#echo-configuration), but additionally provides the opportunity to do some math (smoothing, averages) or other logic (choosing sensors in occupied rooms) before calculating the temperature the heat pump should use as current.

An example automation (**this automation does not have a safety check for failed sensors!**) below:
```yaml
alias: Report Temperature - Basement
description: ""
mode: single
triggers:
  - entity_id:
      - sensor.env_basement_temperature
    trigger: state
conditions: []
actions:
  - data:
      current_temperature_C: "{{float(states('sensor.env_basement_temperature'))}}"
    action: esphome.env_basement_hp_report_temperature
```