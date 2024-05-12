import DocCardList from '@theme/DocCardList';

# IT Protocol Packet Reference

Packets sent on Mitsubishi's CN105 port seem to follow a general structure, but the specific content is still not 
entirely well mapped out.  Eventually I'm hoping to have this wiki compile all the known information, but quite a bit 
of data is available nonetheless.

## Packet Header

All packets have a 5 byte header at the beginning, and a 1 byte checksum at the end.  Most packets seem to have a paired
request/response structure.

| Byte | Purpose             | Possible Values   | Supported by mUART        |
|------|---------------------|-------------------|---------------------------|
| 0    | Sync                | 0xFC              | Yes                       |
| 1    | Packet Type         | See this section. | Most types to some extent |
| 2-3  | Protocol Identifier | 0x0130            | N/A                       |
| 4    | Payload Size        | 0x00-0x10         | Yes                       |

The protocol specification appears to require packet lengths of `0x01`, `0x02`, or `0x10`, depending on the packet type.
Most packets will use a length of `0x10` even when the extra bytes are not relevant. Similarly, most units seem to 
accept packets of any length (though caution is advised).

<DocCardList />