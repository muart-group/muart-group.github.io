import DocCardList from '@theme/DocCardList';

# Packet `0x62`: Get Response

This packet is issued by the heat pump in response to a [`0x42` - Get Request](0x42-get-request) packet. Unlike the 
ack-only form of Packet 0x61, this packet will include response information.

The first byte of this packet represents the command type that is being responded to. That is, if a device requested 
0x02, the first byte of this packet will in turn be 0x02.

| Byte | Purpose         | Possible Values | Supported by mUART | Notes                                                         |
|------|-----------------|-----------------|--------------------|---------------------------------------------------------------|
| 0    | CommandType     | Multiple        | Partial            |
| 1-15 | Packet Specific | N/A             | N/A                | The exact contents of these bytes depend on the command type. |

Firmware dumps have revealed the existence of packets `0x50`, `0x51`, and `0xA0`, but no information about these command
types exist yet.

## Supported Command IDs

<DocCardList />