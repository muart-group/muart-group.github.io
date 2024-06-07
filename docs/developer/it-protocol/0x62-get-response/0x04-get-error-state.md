# Command `0x04` - Get Error State

This packet is occasionally sent by the MHK2 to retrieve error information from the heat pump.

| Byte | Purpose            | Possible Values | Supported by mUART | Notes                                                       |
|------|--------------------|-----------------|--------------------|-------------------------------------------------------------|
| 0    | CommandType        | 0x04            | Yes                |
| 4-5  | Error Code         | 0x8000          | Partial            | 0x8000 is "all clear", other values TBD                     |
| 6    | Two Character Code | 0x00            | Partial            | User-friendly (?) error code<br/>0x00 (`A0`) is "all clear" |

Certain error codes have a textual representation at https://app.kumocloud.com/json/fault-codes.json. The two-character
code needs to be mapped from hex to a specific display format.

The two-character-code will need to be converted from hex into a human-readable format, which may be done using the 
following sample code (n.b. requires validation):

```python
def convert_two_char(code):
    upper_alpha = "AbEFJLPU"
    lower_alpha = "0123456789ABCDEFOHJLPU"
    
    return upper_alpha[(code & 0xE0) >> 5] + lower_alpha[code & 0x1f]
```
