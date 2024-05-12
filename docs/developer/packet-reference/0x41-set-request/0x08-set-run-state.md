# Command `0x08` - Set Run State

Seems to correlate (at least partially) with [`0x62 0x09` - Get Run State][get-run-state]. Name/other flags TBD.

| Byte | Purpose      | Possible Values        | Supported by mUART | Notes                                 |
|------|--------------|------------------------|--------------------|---------------------------------------|
| 0    | Command Type | 0x01                   | Yes                |
| 1-2  | Update Flags | Traditional hex flags  | Partially          | Indicates which parameters to update. |
| 3    | Filter Reset | 0x00: No<br/>0x01: Yes |                    | Update flag 0x0001                    |

[get-run-state]: /developer/packet-reference/0x62-get-response/0x09-get-run-state