# Timestamps

Communication between the Kumo Cloud and MHK2 units will include certain timestamps spanned over four bytes. Mitsubishi
encodes these in a bitfield in form `YYYYYY mmmm DDDDD HHHHH MMMMMM SSSSSS`. In the below chart, but 1 is the rightmost.

| Bits  | Purpose             |
|-------|---------------------|
| 1-6   | Second (0-59)       |
| 7-12  | Minute (0-59)       |
| 13-17 | Hour (0-23)         |
| 18-22 | Day of Month (1-31) |
| 23-26 | Month (1-12)        |
| 27-32 | Year (since 2017)   |

Conversions can be done with the following code:

```python
def convert_date_time(dt):
    return (dt.year - 2017) << 26 | \
           (dt.month << 22) | \
           (dt.day << 17) | \
           (dt.hour << 12) | \
           (dt.minute << 6) | \
           (dt.second)

def from_magic(magic):
    seconds = magic & 63
    minutes = (magic >> 6) & 63
    hours = (magic >> 12) & 31
    days = (magic >> 17) & 31
    months = (magic >> 22) & 15
    years = (magic >> 26) + 2017
    return datetime.datetime(years, months, days, hours, minutes, seconds)
```
