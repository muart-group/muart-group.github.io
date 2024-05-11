# Packet `0x62`: Get Response

This packet is sent by the heat pump in response to a (0x42) Get Request packet. Unlike the ack-only form of Packet 
0x61, this packet will include response information.

The first byte of this packet represents the command type that is being responded to. That is, if a device requested 
0x02, the first byte of this packet will in turn be 0x02.