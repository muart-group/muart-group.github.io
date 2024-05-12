# Command `0xA8` - Unknown Kumo Packet

Sent from the MHK2 to a Kumo Cloud unit, captured via logic analyzer.

| Byte | Purpose                | Possible Values                                   | Supported by mUART | Notes                               |
|------|------------------------|---------------------------------------------------|--------------------|-------------------------------------|
| 0    | Command Type           | 0xA8                                              | No                 |                                     |
| 1    | Flags                  | Traditional hex flags                             |                    | Determines which fields to process  |
| 2-5  | Thermostat Time (?)    | See [[Timestamps\|Special Data Types#Timestamps]] |                    | Flag 0x01                           |
| 6    | ???                    | 0x00, 0x01                                        |                    | Flag 0x02                           |
| 7    | ???                    | 0x00, 0x01, 0x02                                  |                    | Flag 0x04                           |
| 8    | Auto Heat Setpoint (?) | Varies                                            |                    | Flag 0x08<br/>Resets if invalid (?) |
| 9    | Auto Cool Setpoint (?) | Varies                                            |                    | Flag 0x10<br/>Resets if invalid (?) |
| 10   | ???                    | 0x00, 0x01                                        |                    | Flag 0x20                           |
| 11   | ???                    | 0x00, 0x01                                        |                    | Flag 0x40                           |

Sample Packets:
```
[FC 41 01 30 10] A8 01 1C DD 51 E0 00 00 00 00 00 00 00 00 00 00 [AB]
[FC 41 01 30 10] A8 01 1C DD 51 EA 00 00 00 00 00 00 00 00 00 00 [A1]
[FC 41 01 30 10] A8 01 1C DD 51 F3 00 00 00 00 00 00 00 00 00 00 [98]
[FC 41 01 30 10] A8 18 00 00 00 00 00 00 AD B3 00 00 00 00 00 00 [5E]  // ???????
[FC 41 01 30 10] A8 01 1C DD 52 06 00 00 00 00 00 00 00 00 00 00 [84]
[FC 41 01 30 10] A8 01 1C DD 52 11 00 00 00 00 00 00 00 00 00 00 [79]
[FC 41 01 30 10] A8 01 1C DD 52 19 00 00 00 00 00 00 00 00 00 00 [71]
[FC 41 01 30 10] A8 01 1C DD 52 23 00 00 00 00 00 00 00 00 00 00 [67]
[FC 41 01 30 10] A8 01 1C DD 52 2B 00 00 00 00 00 00 00 00 00 00 [5F]
[FC 41 01 30 10] A8 01 1C DD 52 35 00 00 00 00 00 00 00 00 00 00 [55]
[FC 41 01 30 10] A8 01 1C DD 52 43 00 00 00 00 00 00 00 00 00 00 [47]
[FC 41 01 30 10] A8 01 1C DD 52 4D 00 00 00 00 00 00 00 00 00 00 [3D]
[FC 41 01 30 10] A8 01 1C DD 52 57 00 00 00 00 00 00 00 00 00 00 [33]
[FC 41 01 30 10] A8 01 1C DD 52 60 00 00 00 00 00 00 00 00 00 00 [2A]
[FC 41 01 30 10] A8 01 1C DD 52 68 00 00 00 00 00 00 00 00 00 00 [22]
```

See [this page](https://github.com/Sammy1Am/mitsubishi-uart/wiki/Interesting-Packets#kumomhk2-heartbeat) for in-situ information about this packet.