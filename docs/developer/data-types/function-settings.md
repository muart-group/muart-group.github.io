# Function Settings

Packet command types `0x1F` to `0x22` will encode function information in another bit-packed field, where the first bit
is ignored, the second five bits are the setting code and the final two bits are the setting value, e.g. `X CCCCC VV`.

```python3
# assumes `data` is an array of bytes
def decode_setting(data):
    result = {}
    
    for b in data:
        if (b == 0x00) continue
        
        result[(b & 0x7C) >> 2] = b & 0x03
    
    return result
```

Function codes are constrained between 1 and 31, and values are constrained between 0 and 3. A full list of functions
(and what they control) is available in [the MHK2 manual][mhk2-manual] as well as the manual(s) for relevant indoor 
units. Note that some systems will shift their codespace up to 100 to 131, though this does not appear to actually cause
any semantic difference.

A value of `0` appears to indicate a special "use default" value, but this has not yet been confirmed.

[mhk2-manual]: https://mylinkdrive.com/USA/Controls/MHK2?product&categoryName=Controls