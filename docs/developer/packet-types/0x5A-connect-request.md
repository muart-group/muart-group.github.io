# Packet `0x5A`: Connect Request

This packet appears to be sent by the thermostat as part of establishing communication to a heat pump or Kumo Cloud 
unit. It appears to be an initial communication handshake attempt. The other device will respond with a 
(0x7A) Connect Response when it is available.

| Byte | Purpose      | Possible Values | Supported by mUART | Notes |
|------|--------------|-----------------|--------------------|-------|
| 0    | CommandType? | 0xCA            |                    |
| 1    |              | 0x01            |                    |       |