---
slug: /
---

# mUART Project Home

Mitsubishi UART (otherwise known as mUART) is a project to reverse engineer the CN105 protocol used by Mitsubishi
Electric air-to-air heat pumps for the purposes of creating a first-class ESPHome component.

:::tip
In a rush? Check out the [user docs](user) to get started, or the [developer docs](developer) to get hacking!
:::

Building on the work of the seminal [SwiCago/HeatPump](https://github.com/SwiCago/HeatPump) and 
[geoffdavis/esphome-mitsubishiheatpump](https://github.com/geoffdavis/esphome-mitsubishiheatpump), this library aims to 
take advantage of more recent developments (e.g. parity support in ESPHome's software UART) to provide a more compact 
and feature-complete ESPHome component for heat pump control. The project also natively supports integration with MHK 
thermostats similar to [akamali/mhk1_mqtt](https://github.com/akamali/mhk1_mqtt), but built in a ESPHome-native way with
a closer focus on hardware interoperability.

This library aims to support most air-to-air heat pumps supported by Kumo Cloud (and likely MELCloud/MELView), with
a focus on providing feature parity with these commercial offerings.

## Features

* Supports adding additional ESPHome sensors as remote temperature sources
* Support for software UART interfaces
* Support for connecting a MHK2 (and possibly MHK1) to a second software UART
* Parity with the above-mentioned libraries