# Useful Configuration Snippets

## Setting a default temperature source

The MITP code *should* remember your last selected temperature source and revert to it on startup.  However this doesn't work when updating the firmware and (potentially) in some crash scenarios.  This configuration can be added to automatically select a temperature source on startup.

First, ensure your `temperature_source` `select` component has an `id` specified:
```yaml
select:
  - platform: mitsubishi_itp
    temperature_source:
      name: "Temperature Source"
      id: temp_source_select
      sources: []
```

And then add this `on_boot` section to `esphome` in your config:
```yaml
esphome:
  on_boot:
    priority: 260
    then:
      - select.set:
          id: temp_source_select
          option: "Thermostat"
```

Where `"Thermostat"` is the display name of the temperature source you want to select.  "Internal" will always be present and "Thermostat" will be present if a thermostat is configured.

## Don't report out-of-range sensor values

The Outdoor Temperature sensor on some units only reports valid values when the compressor is running, and otherwise reports the equivalent of -63.5C.  This adding this `filters` section will replace those -63.5C values with "unknown" in Home Assistant and should help graphs be more readable.

```yaml
sensor:
  - platform: mitsubishi_itp
    outdoor_temperature:
      name: "Outdoor Temperature"
      filters:
      - lambda: |-
          if (x > -63) return x;
          return NAN;
```

## Use Mitsubishi temperature conversion

Mitsubishi products like their thermostat don't use a simple formula or rounding for converting C to F.  Unfortunately this can lead to inconsistent behavior when trying to e.g. compare a thermostat's F values to Home Assistant's F values.  This code snippet allows you to convert values using Mitsubishi's lookup tables (or a reasonable subsection thereof) for consistency.


First you'll need to define the lookup table (as two arrays).  This is long and cumbersome-- you can shorten it if you're expecting a smaller range of temperatures.
<details>
```yaml
globals:
  - id: m_ctof_c
    type: float[157]
    initial_value: |-
      {-18,
      -17.5,
      -17,
      -16.5,
      -16,
      -15.5,
      -15,
      -14.5,
      -14,
      -13.5,
      -13,
      -12.5,
      -12,
      -11.5,
      -11,
      -10.5,
      -10,
      -9.5,
      -9,
      -8.5,
      -8,
      -7.5,
      -7,
      -6.5,
      -6,
      -5.5,
      -5,
      -4.5,
      -4,
      -3.5,
      -3,
      -2.5,
      -2,
      -1.5,
      -1,
      -0.5,
      0,
      0.5,
      1,
      1.5,
      2,
      2.5,
      3,
      3.5,
      4,
      4.5,
      5,
      5.5,
      6,
      6.5,
      7,
      7.5,
      8,
      8.5,
      9,
      9.5,
      10,
      10.5,
      11,
      11.5,
      12,
      12.5,
      13,
      13.5,
      14,
      14.5,
      15,
      15.5,
      16,
      16.5,
      17,
      17.5,
      18,
      18.5,
      19,
      19.5,
      20,
      20.5,
      21,
      21.5,
      22,
      22.5,
      23,
      23.5,
      24,
      24.5,
      25,
      25.5,
      26,
      26.5,
      27,
      27.5,
      28,
      28.5,
      29,
      29.5,
      30,
      30.5,
      31,
      31.5,
      32,
      32.5,
      33,
      33.5,
      34,
      34.5,
      35,
      35.5,
      36,
      36.5,
      37,
      37.5,
      38,
      38.5,
      39,
      39.5,
      40,
      40.5,
      41,
      41.5,
      42,
      42.5,
      43,
      43.5,
      44,
      44.5,
      45,
      45.5,
      46,
      46.5,
      47,
      47.5,
      48,
      48.5,
      49,
      49.5,
      50,
      50.5,
      51,
      51.5,
      52,
      52.5,
      53,
      53.5,
      54,
      54.5,
      55,
      55.5,
      56,
      56.5,
      57,
      57.5,
      58,
      58.5,
      59,
      59.5,
      60}
  - id: m_ctof_f
    type: float[157]
    initial_value: |-
      {0,
      1,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      46,
      46,
      47,
      48,
      49,
      50,
      51,
      52,
      53,
      53,
      54,
      55,
      56,
      57,
      58,
      59,
      60,
      61,
      62,
      63,
      64,
      65,
      66,
      67,
      67,
      68,
      68,
      69,
      70,
      71,
      72,
      73,
      74,
      75,
      76,
      77,
      78,
      79,
      80,
      81,
      82,
      83,
      84,
      85,
      86,
      87,
      88,
      88,
      89,
      89,
      90,
      91,
      92,
      93,
      94,
      95,
      96,
      97,
      98,
      99,
      100,
      100,
      101,
      102,
      103,
      104,
      105,
      106,
      107,
      108,
      109,
      109,
      110,
      111,
      112,
      113,
      114,
      115,
      116,
      117,
      118,
      118,
      119,
      120,
      121,
      122,
      123,
      124,
      125,
      126,
      127,
      127,
      128,
      129,
      130,
      131,
      132,
      133,
      134,
      135,
      136,
      136,
      137,
      138,
      139,
      140}
```
</details>

Then you can use this lambda to convert between the C in the table to F for reporting to Home Assistant.  In this example the result is reported as a separate sensor.

```yaml
sensor:
  - platform: template
      name: "Temperature In F"
      lambda: |-
        float celsius = id(temperature_source_in_c).state;
        for (int i = 0; i < sizeof(id(m_ctof_c))/sizeof(id(m_ctof_c)[0]); i++) {
          if (id(m_ctof_c)[i] == celsius) {
            return id(m_ctof_f)[i];
          }
        }
        // Default fallback if exact match is not found
        return (celsius * 9.0 / 5.0) + 32.0;
      update_interval: 60s
```