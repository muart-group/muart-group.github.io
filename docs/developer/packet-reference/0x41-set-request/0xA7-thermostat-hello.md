# Command `0xA7` - Thermostat Hello

This packet is occasionally sent by the MHK2 thermostat, but only appears to receive a response when the Kumo Cloud is
connected. When the MHK2 is attached to a Kumo Cloud, a (0x61) Set Response packet will be sent in return.

| Byte  | Purpose                     | Possible Values | Supported by mUART | Notes                                         |
|-------|-----------------------------|-----------------|--------------------|-----------------------------------------------|
| 0     | Command ID                  | 0xA7            | No                 |                                               |
| 1-3   | Thermostat Model Number     | Varies          |                    |                                               |
| 4-12  | Thermostat Serial Number    | Varies          |                    | Missing the preceding `2`, same as Kumo's API |
| 13-15 | Thermostat Firmware Version | Varies          |                    | Major/Minor/Revision                          |

The Model Number and Serial Number fields are packaged in six-bit fields that need to be specifically extracted. Sample
code for this is as follows:

```python
def decode_serial(encoded_serial, word_size = 6):
    length = math.ceil(encoded_serial.bit_length() / word_size)
    result = ""
    
    for i in reversed(range(0, length)):
        byte = (encoded_serial >> (word_size * i)) & ((2 ** word_size) - 1)
        
        result += chr(byte) if byte > 0x1F else chr(byte + 0x40)
    
    return result
```

The serial number and version fields *may* be missing (returning all zeroes), though reasons for this are currently not 
well understood.
