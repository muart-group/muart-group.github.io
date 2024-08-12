---
sidebar_position: 0
---

# Getting Started with mUART

As mUART is based on the ESPHome framework, it's rather simple to get started with your own hardware.

:::warning
This project is not associated with Mitsubishi Electric, and *certainly* is not endorsed by them. While the developers
of this project have safety and compatibility as a priority, there can be unforeseen consequences.

By using this project, you may void your warranty, break your heat pump, or risk your significant other waking you up at
3 AM because it's too hot, and they can't turn the heater off.
:::

## Hardware Design

SwiCago has generously shared a [demo schematic](https://github.com/SwiCago/HeatPump?tab=readme-ov-file#demo-circuit)
that will be the base of the hardware. Refer to this if you get lost. For the closest to "ready-to-go" design, consider
using [a Wemos D1 Mini](https://github.com/SwiCago/HeatPump/issues/13#issuecomment-457897457).

The Mitsubishi CN105 port is fortunately [rather well documented](https://nicegear.nz/blog/hacking-a-mitsubishi-heat-pump-air-conditioner/)
at this point. It exposes five pins:

| Pin | Purpose                          | Connects To                              |
|-----|----------------------------------|------------------------------------------|
| 1   | +12V DC                          | N/C or Voltage Regulator                 |
| 2   | Ground                           | Ground                                   |
| 3   | +5V DC                           | Microcontroller +5V or Voltage Regulator |
| 4   | Heat Pump TX <br/> Thermostat RX | Microcontroller RX                       |
| 5   | Heat Pump RX <br/> Thermostat TX | Microcontroller TX                       |

Note that the TX/RX pins both provide and expect 5 volts. While most ESP chips are okay with this and heat pumps seem to 
not care about only getting 3.3 volts back, the baud rate of the serial connection means that a 
[level shifter](https://www.sparkfun.com/products/12009) can be used for extra safety. Similarly, the ESP may be powered 
directly via the +5V DC connection or by using a buck converter (e.g. the 
[MPM3610](https://www.adafruit.com/product/4683)) to convert the +12V to +3.3V for powering the chip.

While it is preferable to use hardware UART pins (especially for the heat pump connection), software UART has been
tested to work on an ESP8266.

## Minimal ESPHome Configuration

As of the time of writing, this project has not yet been included into the ESPHome mainline. As such, it will need to be
manually retrieved from the mUART fork. This is reflected in the minimal example below:

```yaml
external_components:
  - source: github://muart-group/esphome@dev
    components: [ mitsubishi_itp ]
    
# Remember to disable logger if using the primary UART!
logger:
  baud_rate: 0

uart:
  - id: hp_uart
    baud_rate: 2400  # Note: May be 9600 on some systems!
    parity: EVEN
    rx_pin:
      number: GPIO3
    tx_pin:
      number: GPIO1

climate:
  - platform: mitsubishi_itp
    name: "Climate"
    uart_heatpump: hp_uart
```

More advanced configuration options are available in the [configuration](configuration/index.md) pages of this document.


## Other Projects

If this project doesn't suit your needs, please consider checking out some of the other major projects also working on
CN105 hacking:

* [geoffdavis/esphome-mitsubishiheatpump](https://github.com/geoffdavis/esphome-mitsubishiheatpump)
* [echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome)
* [gysmo38/mitsubishi2MQTT](https://github.com/gysmo38/mitsubishi2MQTT)

A number of commercial products also exist for controlling Mitubishi Electric heat pumps via CN105:

* [Airzone Aidoo WiFi](https://www.airzonecontrol.com/na/en/control-solutions/aidoo/wi-fi/)
  * Two separate part numbers: AZAI6WSCMEL (bridge), AZX6ACCSPLMEL (CN105 splitter)
* [Intesis Home Automation Interface](https://www.hms-networks.com/p/inwmpmit001i000-mitsubishi-electric-domestic-mr-slim-and-city-multi-to-home-automation-interface?tab=tab-specification)
  * Part Number INWMPMIT001I000
* [CoolMaster CoolPlug](https://coolautomation.com/products/coolplug-coolinkhub/)
  * Part Number CO-CP-WRLS-ME
 
If you have one of these units already, please get in touch with us! We'd love to learn more about how they work.

Alternatively you can consider...

## Contributing

mUART also has extensive [developer documentation](../developer) on the CN105 protocol, and we are always willing to 
look at PRs or feature requests! 
