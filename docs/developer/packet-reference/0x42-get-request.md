# Packet `0x42`: Get Request

This packet appears to be a generic "get" command to the HVAC unit, and is used to query information about the heat 
pump. This packet type is analogous to an HTTP `GET` request. The response to this packet will be a 
[`0x62` - Get Response][get-response] packet.

The first byte of this packet contains the command type to retrieve information about, which is also used as a 
disambiguator. This field does not appear to normally have a body under standard operating conditions - except for 
[one known case](https://github.com/Sammy1Am/mitsubishi-uart/wiki/Interesting-Packets#kumomhk2-heartbeat).

| Byte | Purpose     | Possible Values | Supported by mUART | Notes                |
|------|-------------|-----------------|--------------------|----------------------|
| 0    | CommandType | Multiple        | Partial            |
| 1-15 | Body?       | N/A             | N/A                | Typically all zeroes |

The command types for this packet are listed in the [`0x62` - Get Response][get-response], as bodies usually aren't 
relevant here.

[get-response]: 0x62-get-response