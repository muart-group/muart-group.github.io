# Command `0x08` - Set Run State

Seems to correlate (at least partially) with [`0x62 0x09` - Get Run State][get-run-state]. Name/other flags TBD.

| Byte | Purpose                             | Possible Values        | Supported by mUART | Notes                                 |
|------|-------------------------------------|------------------------|--------------------|---------------------------------------|
| 0    | Command Type                        | 0x08                   | Yes                |                                       |
| 1-2  | Update Flags                        | Traditional hex flags  | Partially          | Indicates which parameters to update. |
| 3    | Filter Reset                        | 0x00: No<br/>0x01: Yes |                    | Update flag 0x0001                    |
| 5    | (UNCONFIRMED) Dehumidify Value      | 0x00 to 0x64 (?)       |                    | Update flag 0x0004                    |    
| 6    | (UNCONFIRMED) Power Saving Mode     | 0x00: Off<br/>0x0A: On |                    | Update flag 0x0008                    |
| 7    | (UNCONFIRMED) "Wind and Wind Break" |                        |                    | Update flag 0x0020                    |
| 8    | (UNCONFIRMED) Buzzer                | 0x00: No<br/>0x01: Yes |                    | Update flag 0x0010                    |

[get-run-state]: ../0x62-get-response/0x09-get-run-state.md
