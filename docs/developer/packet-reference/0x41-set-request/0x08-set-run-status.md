# Command `0x08` - Set Run Status

Seems to correlate (at least partially) with command 0x09. Name/other flags TBD.

| Byte | Purpose      | Possible Values        | Supported by mUART | Notes                                 |
|------|--------------|------------------------|--------------------|---------------------------------------|
| 0    | Command Type | 0x01                   | Yes                |
| 1-2  | Update Flags | Traditional hex flags  | Partially          | Indicates which parameters to update. |
| 3    | Filter Reset | 0x00: No<br/>0x01: Yes |                    | Update flag 0x0001                    |