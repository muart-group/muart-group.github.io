# Command `0x05` - Get Timer Info

:::note
This packet's information was pulled from [SwiCago's HeatPump](https://github.com/SwiCago/HeatPump/) library. It has yet
to be verified.
:::


| Byte | Purpose               | Possible Values                                                | Supported by mUART | Notes                                                 |
|------|-----------------------|----------------------------------------------------------------|--------------------|-------------------------------------------------------|
| 0    | Command Type          | 0x05                                                           | No                 |
| 3    | Timer Mode            | 0x00: None<br/>0x01: Off Only<br/>0x02: On Only<br/>0x03: Both | No                 |                                                       |
| 4    | On Minutes Set        |                                                                | No                 | Indicates how many minutes the ON timer was set for.  |
| 5    | Off Minutes Set       |                                                                | No                 | Indicates remaining time until the unit turns on.     |
| 6    | On Minutes Remaining  |                                                                | No                 | Indicates how many minutes the OFF timer was set for. |
| 7    | Off Minutes Remaining |                                                                | No                 | Indicates remaining time until the unit turns off.    |