# Command `0x02` - Get Current Settings

This packet's structure and contained information is very similar to that of 
[`0x41 0x01` - Set Settings][set-settings], and a significant amount of data appears to be shared. Please consult that 
page for additional information about the below fields.

| Byte | Purpose                             | Possible Values | Supported by mUART | Notes                   |
|------|-------------------------------------|-----------------|--------------------|-------------------------|
| 0    | Command                             | 0x02            | Yes                |                         |
| 3    | Power                               |                 | No                 |                         |
| 4    | Operating Mode                      |                 | No                 |                         |
| 5    | Legacy Target Temperature           |                 |                    |                         |
| 6    | Fan Speed                           |                 |                    |                         |
| 7    | Vertical Vane                       |                 |                    |                         |
| 8    | Prohibit Flags                      |                 |                    |                         |
| 9    |                                     |                 |                    |                         |
| 10   | Horizontal Vane                     |                 |                    |                         |
| 11   | Target Temperature                  |                 |                    |                         |
| 12   | (UNCONFIRMED) Target Humidity       |                 |                    | Possibly JP units only? | 
| 13   | (UNCONFIRMED) Power Saving Mode     |                 |                    | Possibly JP units only? | 
| 14   | Airflow control mode (i-See)        | See<br/>[`0x41 0x08` - Set Run State][set-run-state] |   | E.g MSZ-LN25VG2W | 
| 15   | (UNCONFIRMED) Left Vertical Vane    |                 |                    | Possibly JP units only? | 

[set-settings]: ../0x41-set-request/0x01-set-settings.md
[set-run-state]: ../0x41-set-request/0x08-set-run-state.md

## Horizontal Vanes

For currently unknown reasons, certain units will have the most significant bit (0x80) set for the horizontal vane
field. The purpose of this bit is currently unknown, though it may vary between unit types. For example, on the 
MSZ-FS##NA unit, this bit is set when indirect/direct mode is enabled.

Preliminary testing has shown that this bit need not be set to update the horizontal vane state.
