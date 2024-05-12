# Packet `0x41`: Set Request

This packet appears to be a generic "set" command to the HVAC unit and is used to apply a new state. Conceptually, this
packet can be seen as an HTTP `POST` or `PUT` request to the HVAC unit. The response to this packet *may* be a 
(0x61) Set Response packet.

The first byte of this packet is the command type, which is used as a disambiguator.

| Byte | Purpose         | Possible Values | Supported by mUART | Notes                                                        |
|------|-----------------|-----------------|--------------------|--------------------------------------------------------------|
| 0    | CommandType     | Multiple        | Partial            |                                                              |
| 1-15 | Packet Specific | N/A             | N/A                | The exact contents of these bytes depend on the command type |