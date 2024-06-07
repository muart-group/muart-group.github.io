---
sidebar_position: 40
---

# Packet `0x5B`: Identify Request

This packet is used to request information about the connected heat pump, such as capabilities and model information. This is
normally requested by an MHK/Kumo unit to determine which features to enable.

The heat pump will respond with the relevant information in a [`0x7B` - Identify Response][identify-response] packet.

| Byte | Purpose      | Possible Values | Supported by mUART | Notes |
|------|--------------|-----------------|--------------------|-------|
| 0    | CommandType  | Varies          |                    |       |

## Command Types

This packet allows requesting multiple different packets which contain different information. Not all packets are available
on all units, and some packets may be region-locked as well.

For a full list of command types, refer to the [`0x7B` - Identify Response][identify-response] documentation.

[identify-response]: 0x7B-identify-response
