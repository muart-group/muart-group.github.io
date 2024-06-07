# Command `0x20` and `0x22` - Get Functions

Sent as a response to requesting current installer functions from the heat pump. Command `0x20` denotes the first page 
of 14 functions, while command `0x21` denotes the second page.

Settings may be edited via [`0x41 0x1F` - Set Functions][set-functions], but care
must be taken when using this function.

| Byte | Purpose           | Possible Values                            | Supported by mUART | Notes                                    |
|------|-------------------|--------------------------------------------|--------------------|------------------------------------------|
| 0    | Command Type      | 0x20, 0x22                                 | No                 |
| 1-14 | Function Settings | See [Function Settings][function-datatype] |                    |                                          |
| 15   | End Byte          | 0x00                                       |                    | Unsure if 0x00 has a specific value here |

[set-functions]: ../0x41-set-request/0x1F-0x21-set-functions.md
[function-datatype]: ../data-types/function-settings.md