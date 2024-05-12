---
sidebar_position: 1
---

# Developing mUART

foo bar baz

## Related Repositories

This repository is far from the only one working on CN105 protocol hacking. The below repositories contain different 
implementations, sample code, feature sets, or known capabilities.

* **[SwiCago/HeatPump](https://github.com/SwiCago/HeatPump)** - This is the canonical reference for CN105 control for 
  now, and is probably one of the most documented systems to date.
    * [Issue #39](https://github.com/SwiCago/HeatPump/issues/39) contains a list of packets that have been discovered by 
      the community.
    * There's also [a chat room](https://app.gitter.im/#/room/#Mitsubishi-Heat-Pump_Lobby:gitter.im) for this that's 
      reasonably active.
* **[m000c400/Mitsubishi-CN105-Protocol-Decode](https://github.com/m000c400/Mitsubishi-CN105-Protocol-Decode)** - 
  Reference for Ecodan/Hot Water Heat Pump Systems
    * Also has [a chat room](https://app.gitter.im/#/room/#Mitsubishi-CN105-Protocol-Decode_community:gitter.im) 
      available.
    * Doesn't focus much on heaters (protocol identifier `0x027A`), but still helpful as a systems reference even if 
      packets aren't applicable.
* **[geoffdavis/esphome-mitsubishiheatpump](https://github.com/geoffdavis/esphome-mitsubishiheatpump)** - Another 
  seminal library based off of SwiCago's work for ESPHome/HA.
* **[akamali/mitsubishi_heatpump_emulator](https://github.com/akamali/mitsubishi_heatpump_emulator)** - A relatively 
  feature-filled emulator for CN105 heat pumps; useful for debugging and contains some other interesting research.
* **[akamali/mhk1_mqtt](https://github.com/akamali/mhk1_mqtt)** - Another ready-to-use library with support for MHK1 
  passthrough.
* **[dlarrick/pykumo](https://github.com/dlarrick/pykumo)** - A library for interfacing with Kumo Cloud. Useful for data 
  association purposes.
* **[echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome)** - Another ESPHome library with 
  some extra findings.
* **[vilppuvuorinen/pymelcloud](https://github.com/vilppuvuorinen/pymelcloud)** - A library for interfacing via 
  MELCloud, which is now defunct (?). May contain extra findings or data associations.

## More Esoteric Information

As part of reverse engineering these units (especially within the context of getting the MHK2 to work) some extra data 
sources of interest have been found. These tend to be more complex to use or are more questionable, but may be useful 
nonetheless.

* The (uglified) JavaScript code available at https://app.kumocloud.com/ exposes some interesting information as well as 
  names of various key services. Note, however, that this code works far more with the Kumo side of things and may not 
  contain information useful for raw IT protocol decoding.
* Firmware versions 02.01.04 and 02.16.12 for the `PAC-USWHS002-WF-2` unit have been extracted from the device flash and 
  are available for analysis. "Fake flash" dumps and firmware information are available in Swicago's Gitter room. Note 
  that only static analysis may be performed on these devices - MEHVAC has appeared to (mostly) properly secure their 
  devices, so typical reverse engineering methods do not work.
* Data can be captured over the wire using a logic analyzer capable of decoding UART signals at 2400 baud/8E1. It is 
  also possible to use the mitsubishi-uart project in passive mode to log captured packets.

## Documenting Information

This documentation is available [on GitHub](https://github.com/muart-group/muart-group.github.io/) and is open for pull
requests, issues, and edits. If any useful or relevant information appears to be missing or otherwise is not as
accessible as it should be, edits are welcome!
