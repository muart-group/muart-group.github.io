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

## Known Packet Types

<DocCardList />

## Known Command IDs

The below table is a quick reference of all known command IDs (otherwise known as *attribution groups* in Kumo's code) 
that are currently known. These only apply to packets [`0x41` - Set Request](0x41-set-request) and 
[`0x62` - Get Response](0x62-get-response) (and their companions `0x42` and `0x61`, respectively). 

| Command ID       | Name                     | Communication Flow |
|------------------|--------------------------|--------------------|
| [0x01][ag-01]    | Set Settings             | Kumo/MHK -> HP     |
| [0x02][ag-02]    | Get Settings             | HP -> Kumo/MHK     |
| [0x03][ag-03]    | Get Temperatures         | HP -> Kumo/MHK     |
| [0x04][ag-04]    | Get Error State          | HP -> Kumo/MHK     |
| [0x05][ag-05]    | Get Timer Info           | HP -> Kumo/MHK     |
| [0x06][ag-06]    | Get Operation State      | HP -> Kumo/MHK     |
| [0x07][ag-07]    | Set Remote Temperature   | Kumo/MHK -> HP     |
| [0x08][ag-08]    | Set Run State            | Kumo/MHK -> HP     |
| [0x09][ag-09]    | Get Run State            | HP -> Kumo/MHK     |
| [0x1F][ag-1F-21] | Set Function Page 1      | Kumo/MHK -> HP     |
| [0x20][ag-20-22] | Get Function Page 1      | HP -> Kumo/MHK     |
| [0x21][ag-1F-21] | Set Function Page 2      | Kumo/MHK -> HP     |
| [0x22][ag-20-22] | Get Function Page 2      | HP -> Kumo/MHK     |
| [0xA6][ag-A6]    | Kumo Sensor Status       | MHK -> Kumo        |
| [0xA7][ag-A7]    | Thermostat Hello         | MHK -> Kumo        |
| [0xA8][ag-A8]    | Unknown Kumo Packet      | MHK -> Kumo        |
| [0xA9][ag-A9]    | Kumo Adapter State       | Kumo -> MHK        |
| [0xAA][ag-AA]    | Unknown Kumo Packet      | MHK -> Kumo        |
| [0xAB][ag-AB]    | Kumo Adapter State       | Kumo -> MHK        |
| [0xC9][ag-C9]    | Extended Heat Pump Hello | HP -> Kumo/MHK     |

[ag-01]: 0x41-set-request/0x01-set-settings
[ag-02]: 0x62-get-response/0x02-get-settings
[ag-03]: 0x62-get-response/0x03-get-temperatures
[ag-04]: 0x62-get-response/0x04-get-error-state
[ag-05]: 0x62-get-response/0x05-get-timer-info
[ag-06]: 0x62-get-response/0x06-get-operation-state
[ag-07]: 0x41-set-request/0x07-set-remote-temperature
[ag-08]: 0x41-set-request/0x08-set-run-state
[ag-09]: 0x62-get-response/0x09-get-run-state
[ag-1F-21]: 0x41-set-request/0x1F-0x21-set-functions
[ag-20-22]: 0x62-get-response/0x20-0x22-get-functions
[ag-A6]: 0x41-set-request/0xA6-kumo-sensor-status
[ag-A7]: 0x41-set-request/0xA7-thermostat-hello
[ag-A8]: 0x41-set-request/0xA8-unknown-kumo-packet
[ag-A9]: 0x62-get-response/0xA9-kumo-adapter-state
[ag-AA]: 0x41-set-request/0xAA-unknown-kumo-packet
[ag-AB]: 0x62-get-response/0xAB-unknown-kumo-packet
[ag-C9]: 0x7B-extended-connect-response
