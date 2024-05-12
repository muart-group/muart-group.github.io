# Packet `0x5B`: Extended Connect Request

Appears to be a request for information about the device on the other side as part of auto-configuration. Sent by the 
thermostat to the heat pump/Kumo unit. A response is expected in the form of a (0x7B) Extended Connect Response packet.

| Byte | Purpose      | Possible Values | Supported by mUART | Notes |
|------|--------------|-----------------|--------------------|-------|
| 0    | CommandType? | 0xC9            |                    |       |
