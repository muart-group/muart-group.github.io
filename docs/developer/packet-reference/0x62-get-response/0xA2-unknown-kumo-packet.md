# Command `0xA2` - Unknown Kumo Packet

The purpose of this packet is currently unknown. Its existence and the below memory map were extracted from a Kumo Cloud
firmware dump.

| Byte | Purpose     | Possible Values | Supported by mUART | Notes                  |
|------|-------------|-----------------|--------------------|------------------------|
| 0    | CommandType | 0xA2            |                    |                        |
| 3-4  | ???         |                 |                    | Read as single `short` |
