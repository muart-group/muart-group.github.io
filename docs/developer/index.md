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
  MELCloud. May contain extra findings or data associations.
* **[ncaunt/meldec](https://github.com/ncaunt/meldec)** - Another MELCloud/Ecodan-focused library, including some rather
  useful reverse engineering notes for the IT protocol. Useful as as systems reference, and contains a couple firmware
  dumps.

## More Esoteric Information

As part of reverse engineering these units (especially within the context of getting the MHK2 to work) some extra data 
sources of interest have been found. These tend to be more complex to use or are more questionable, but may be useful 
nonetheless.

* The web versions of [Kumo Cloud (US)](https://app.kumocloud.com/), [MELCloud (EU)](https://app.melcloud.com/), and
  [MELView (AUS/NZ)](https://app.melview.net) offer interesting tidbits in uglified JavaScript code, including official
  names of certain IT protocol aspects.
* The various Mitsubishi Electric mobile apps contain some hints and possible protocol information. The APKs tend to
  be significantly more accessible than their iOS variants.
  * Kumo Cloud (US): `com.mehvac.kumocloud`
  * MELCloud (EU): `mitsubishi.wifi.android.mitsubishiwifiapp`
  * MELView (AUS/NZ): `net.melview.app` 
  * MELRemo (JP): `jp.co.melco.gemini.mobile.gui`, `jp.co.melco.gemini.mobile.gui.Admin`,
    `jp.co.MitsubishiElectric.MELRemoplus`
* Firmware for certain Mitsubishi control units has been extracted or otherwise found, which can be analyzed using
  the usual static analysis tools. As Mitsubishi seems to properly secure these devices, these firmware images are
  rather difficult to get a hold of and cannot be debugged in situ. Currently, the following firmware has been found:
  * `PAC-USWHS002-WF-2`: Versions 02.01.14 and 02.16.12 are available in SwiCago's Gitter. Most current analysis for
    this project is based around version 02.01.14.
  * `MAC-577IF2-E`: A currently-undetermined firmware version was posted to the MELDec repostiory.
* Data can be captured over the wire using a logic analyzer capable of decoding UART signals at 2400 baud/8E1. It is 
  also possible to use the mitsubishi-uart project in passive mode to log captured packets.

## Documenting Information

This documentation is available [on GitHub](https://github.com/muart-group/muart-group.github.io/) and is open for pull
requests, issues, and edits. If any useful or relevant information appears to be missing or otherwise is not as
accessible as it should be, edits are welcome!
