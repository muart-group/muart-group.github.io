# Packet `0x61`: Set Response

This packet appears to serve as an acknowledgement to a [`0x41` - Set Request](0x41-set-request) packet. It does not 
appear to contain any sort of identification of which packet it is responding to.

| Byte | Purpose      | Possible Values        | Supported by mUART | Notes |
|------|--------------|------------------------|--------------------|-------|
| 0    | ResponseCode | 0x00: OK,  0xFF: Error |                    |       |