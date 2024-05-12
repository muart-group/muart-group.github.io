# Temperature Units

The IT Protocol defines a few different temperature units for internal use. Care must be taken to select the right
temperature unit for any given packet.

## Legacy Setpoint Temperatures

Legacy setpoint temperatures will have a binary value of `0x00` to `0x1F`, which spans the range of 16 to 31.5 degrees 
Celsius.

A wire signal can be converted from a temperature value through the following code:

```python
def legacy_to_celsius(data):
    temp = (31 - data % 0x10)
    
    if data // 0x10 > 0:
        temp += 0.5
    
    return temp
```

It is not known if legacy systems also support fractional values - SWICago's library seems to imply that they do not.

## Legacy Current Temperatures

A couple packets report/use a special scale for "current temperature", otherwise known as "room temperature". Converting
this to degrees Celsius can be done with the formula `10 + data`. Likewise, converting from degrees Celsius is 
`data - 10`. This temperature scale is constrained between 0x00 (10 degrees C) to 0x1F (41 degrees C). At present, no 
logic for fractional units has been detected.

The Kumo JavaScript file also notes a separate temperature scale called `room_temp`, which can be converted to Celsius 
with the formula `8 + data * 0.5`. This temperature is constrained from 8 to 39.5 degrees Celsius. The special value 
0x00 represents any temperature less than or equal to 8 degrees Celsius, while the special value 0x3f represents any 
temperature greater than or equal to 39 degrees Celsius. While the Kumo docs claim this is used in favor of the above 
scale, it is unclear why observations do not match this.

## Enhanced Temperatures

Enhanced temperatures are far simpler to calculate, capable of being converted from the wire using the formula 
`(wire_data - 128) / 2`. Likewise, a temperature value can be converted to wire format using `(temp * 2) + 128`.

## Celsius/Fahrenheit Conversion

As many people may have noticed, Home Assistant and other applications taking care of the C-to-F conversion may end up 
off by a degree. Mitsubishi appears to use a custom lookup table to do these conversions, which has some inconsistencies
like 86 F equaling 29.5 C.

It's suspected that this is caused by a limitation in the ability for certain hardware to properly convert units, 
leading to extremely imprecise rounding. The exact code to get this to work as expected in more sane environments is not
currently known.