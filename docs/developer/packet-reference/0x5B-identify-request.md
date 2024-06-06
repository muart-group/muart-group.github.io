---
sidebar_position: 40
---

# Packet `0x5B`: Identify Request

Appears to be a request for information about the device on the other side as part of autoconfiguration. Sent by the 
thermostat to the heat pump/Kumo unit. A response is expected in the form of a
[`0x7B` - Identify Response](0x7B-identify-response) packet.

| Byte | Purpose      | Possible Values | Supported by mUART | Notes |
|------|--------------|-----------------|--------------------|-------|
| 0    | CommandType? | 0xC9            |                    |       |
