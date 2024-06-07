---
sidebar_position: 20
---

# Packet `0x42`: Get Request

This packet appears to be a generic "get" command to the HVAC unit, and is used to query information about the heat 
pump. This packet type is analogous to an HTTP `GET` request. The response to this packet will be a 
[`0x62` - Get Response][get-response] packet.

The first byte of this packet contains the command type to retrieve information about, which is also used for
disambiguation purposes. This field does not appear to have a body under standard operating conditions, and data
sent via the body fields seem to be ignored.

| Byte | Purpose     | Possible Values | Supported by mUART | Notes                |
|------|-------------|-----------------|--------------------|----------------------|
| 0    | CommandType | Multiple        | Partial            |                      |

A listing of all possible command types that may be requested for this packet are listed in [`0x62` - Get Response](0x62-get-response).
