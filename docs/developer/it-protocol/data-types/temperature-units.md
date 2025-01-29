# Temperature Units

The IT Protocol defines a few different temperature units for internal use. Care must be taken to select the right
temperature unit for any given packet.

## Enhanced Temperatures

Most modern CN105/IT Protocol devices will use an "enhanced temperature" scale (internally known as "temperature scale
A"). A temperature in this scale can be converted to degrees Celsius by using the formula `(data - 128) / 2`. This
scale is constrained between -64°C (value `0x00`) to 63.5°C (value `0xFF`). No special handling appears to exist for
temperatures outside of this scale, likely as this range is not expected to be seen in a residential setting.

A temperature can be converted to wire format by using the inverse formula `(temp * 2) + 128` and trimmed to a single
byte.

## Legacy Temperatures

While most systems observed seem to use the enhanced temperature scale above, certain units will still only accept
or transmit information using legacy scales. Developers are typically encouraged to send both legacy and enhanced
temperature values where appropriate, and prefer reading from enhanced temperature if it exists.

### Setpoint Temperature

Legacy setpoint temperatures will have a binary value of `0x00` to `0x1F`, which spans the range of 16°C to 31.5°C.

A wire signal can be converted from a temperature value through the following code:

```python
def setpoint_to_celsius(data):
    temp = (31 - data % 0x10)
    
    if data // 0x10 > 0:
        temp += 0.5
    
    return temp

def celsius_to_setpoint(temp):
    if temp < 16:
        temp = 16
    
    if temp > 31.5:
        temp = 31.5
    
    wire = (31 - int(temp)) & 0xF
    
    if temp % 1 >= 0.5:
        wire += 0x10
    
    return wire

```

It is not known if legacy systems also support fractional values - SWICago's library seems to imply that they do not.

### Heat Pump Room Temperature

Heat pumps reporting information to a connected thermostat, Kumo unit, or mITP device will use a simplified scale for
the current room temperature.

A temperature in this scale can be converted to Celsius using the formula `10 + data`. This scale is constrained from
10°C (value `0x00`) to 41°C (value `0x1F`), and this scale does not appear to support fractional units. 

A temperature can be converted to wire format by using the inverse formula `temp - 10` and clamping values accordingly.

### Thermostat Room Temperature

Certain (possibly all?) thermostats will report the current room temperature using a special scale capable of supporting
fractional values. This scale was initially discovered in the Kumo JavaScript file, under the name `room_temp`.

A temperature in this scale can be converted to Celsius using the formula `8 + (data * 0.5)`. This scale is constrained
from 8°C (value `0x00`) to 39.5°C (value `0x3F`). If a temperature exceeds either constraint, it will instead be clamped 
accordingly.

A temperature can be converted to wire format by using the inverse formula `(2 * temp) - 16`. The temperature should
be rounded to the nearest half degree, and the final wire result must also be accordingly clamped.

## Celsius/Fahrenheit Conversion

As many people may have noticed, Home Assistant and other applications taking care of the C-to-F conversion may end up 
off by a degree. Mitsubishi appears to use a custom lookup table to do these conversions, which has some inconsistencies
like 86 F equaling 29.5 C.

It's suspected that this is caused by a limitation in the ability for certain hardware to properly convert units, 
leading to extremely imprecise rounding. The exact code to get this to work as expected in more sane environments is not
currently known.