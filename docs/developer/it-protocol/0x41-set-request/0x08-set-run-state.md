# Command `0x08` - Set Run State

Seems to correlate (at least partially) with [`0x62 0x09` - Get Run State][get-run-state]. Name/other flags TBD.

| Byte | Purpose                          | Possible Values                          | Supported by mUART | Notes                                                          |
|------|----------------------------------|------------------------------------------|--------------------|----------------------------------------------------------------|
| 0    | Command Type                     | 0x08                                     | Yes                |                                                                |
| 1-2  | Update Flags                     | Traditional hex flags                    | Partially          | Indicates which parameters to update.                          |
| 3    | Filter Reset                     | 0x00: No<br/>0x01: Yes                   |                    | Update flag 0x0100                                             |
| 4*   | (UNCONFIRMED) Dehumidify Value   | 0x00 to 0x64                             |                    | Update flag 0x0400                                             |    
| 5*   | (UNCONFIRMED) Power Saving Mode  | 0x00: Off<br/>0x0A: On                   |                    | Update flag 0x0800                                             |
| 6**  | Airflow control mode (i-See)     | [Airflow control mode](#airflow-control-mode-i-see) |         | Update flag 0x2000<br/>Not all values supported for all units. |
| 7*   | (UNCONFIRMED) Buzzer             | 0x00: No<br/>0x01: Yes                   |                    | Update flag 0x1000<br/>Sending 0x01 results in some units beeping twice |
| 11*  | (UNCONFIRMED) Notification for remote control navigation | 0x02 : 0x00    |                    | Update flag 0x0002                                             |

**Extracted from Android app 霧ヶ峰REMOTE (v5.3.1)*

***Tested on MSZ-LN25VG2W*

[get-run-state]: ../0x62-get-response/0x09-get-run-state.md

### Airflow control mode (i-See)

| Value | Name     |
|-------|----------|
| 0     | EVEN     |
| 1     | INDIRECT |
| 2     | DIRECT   |

Confirmed to work on units with the i-See sensor and the DIRECTION key on the IR remote (e.g. MSZ-LN##VG#*).
The mode can only be set when the horizontal vane field is set to 0x80 *and* the i-See sensor is activated on the unit.
