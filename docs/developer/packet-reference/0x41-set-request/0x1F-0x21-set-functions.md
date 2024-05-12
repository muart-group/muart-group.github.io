# Command `0x1F` and `0x21` - Set Functions

:::danger
**EDITING THESE SETTINGS MAY CAUSE DAMAGE TO YOUR UNIT. YOU HAVE BEEN WARNED.**

Consult all relevant operation manuals for valid settings and parameters before using this command type.
:::

Sent as part of setting installer functions for the heat pump. Command `0x1F` denotes the first page of 14 functions, 
while command `0x21` denotes the second page. Until more information is known about the function parameters (e.g. if 
only functions to update need be sent), clients should take care to get active functions, modify what they wish to 
change, and then send this command. Likewise, clients should take care to only send packets for the relevant page for 
their units (e.g. do not send a set for a function normally in Page 2 as Page 1).

Settings may be retrieved via [`0x62 0x20` - Get Functions][get-functions].

| Byte | Purpose           | Possible Values                        | Supported by mUART | Notes                                    |
|------|-------------------|----------------------------------------|--------------------|------------------------------------------|
| 0    | Command Type      | 0x1F, 0x21                             | No                 |
| 1-14 | Function Settings | See [Function Settings][function-type] |                    | New settings to apply                    |
| 15   | End Byte          | 0x00                                   |                    | Unsure if 0x00 has a specific value here |

[get-functions]: /developer/packet-reference/0x62-get-response/0x20-0x22-get-functions
[function-type]: /developer/data-types/function-settings