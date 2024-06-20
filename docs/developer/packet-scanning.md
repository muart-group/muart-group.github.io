# Scanning for Supported Packets

:::danger
Packet scanning involves sending an excessive number of packets to a heat pump. Some of these commands may cause
undefined or unexpected behavior. This may break things, possibly badly.
:::

## Using ESPHome over Network

If hardware is already in place, it's probably easiest to use a component like 
[`esphome-stream-server`](https://github.com/oxan/esphome-stream-server) to expose the heat pump's UART to the network.
A sample configuration for this is below. Note that the stream server cannot coexist with the `mitsubishi_itp` 
component.

```yaml
external_components:
  - source: github://oxan/esphome-stream-server
    
uart:
  - id: hp_uart
    baud_rate: 2400
    parity: EVEN
    rx_pin:
      number: GPIO5
    tx_pin:
      number: GPIO17

stream_server:
  - uart_id: hp_uart
```

This can then be used with a brute force script, like below:

```python
import socket
import datetime
import time

HP_HOST = "10.0.2.123"
HP_PORT = 6638

def gen_packet(packet_type, command_type):
    pkt = [0xFC, packet_type, 0x01, 0x30, 0x01, command_type]
    
    # checksum
    checksum = ((0xFC - sum(pkt)) & 0xFF)
    
    pkt += [checksum]
    
    return bytearray(pkt)


def pprint_packet(data):
    preamble = '.'.join([f"{b:02X}" for b in data[0:5]])
    checksum = f"{data[-1]:02X}"
    body = '.'.join([f"{b:02X}" for b in data[5:-1]])
    
    return f"[{preamble}] {body} {checksum}"


def try_packet(sock, ptype, ctype):
    assembled_bytes = gen_packet(ptype, ctype)
    
    sock.send(assembled_bytes)
    
    try:
        recv_bytes = sock.recv(24)
        print(f"[!] PKT 0x{ptype:02X} 0x{ctype:02X} -> {pprint_packet(recv_bytes)}")
    except socket.timeout:
         pass


with socket.socket() as sock:
    sock.connect((HP_HOST, HP_PORT))
    sock.settimeout(2)    
    
    print("Socket connected")
    
    for ctype in range(0x00, 0xFF + 1):
        scan = [0x41, 0x42]
        
        if 0xC0 <= ctype <= 0xDF:
            scan += [0x5B]
        
        for ptype in scan:
            print(f"Testing 0x{ptype:02X} 0x{ctype:02X}\r", end='', flush=True)
            try_packet(sock, ptype, ctype)
```

This script will print all packets that the heat pump responds to, which can be used for diagnostics and development
purposes. The above script will attempt to send "safe" commands with no set flags, but this may not be foolproof.
