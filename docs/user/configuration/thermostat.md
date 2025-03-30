# Connecting a Mitsubishi Thermostat

It's possible to connect a thermostat like an MHK2 (as well as possibly some others!) to the microcontroller to allow
a second point of control (or just to use as a temperature sensor). Note that the thermostat's TX/RX connectors are
inverted - CN105 pin 4 should connect to the defined TX pin, and pin 5 to the defined RX pin.

Once the hardware is ready, a second UART must be defined:

```yaml
uart:
  - id: hp_uart
    ...
  - id: ts_uart
    baud_rate: 2400  # may be 9600
    parity: EVEN
    rx_pin:
      number: GPIO16
    tx_pin:
      number: GPIO14
```

Then, the thermostat must be registered with the component using the special `uart_thermostat` key:

```yaml
climate:
  - platform: mitsubishi_itp
    uart_heatpump: hp_uart
    uart_thermostat: ts_uart
    ...
```

The microcontroller will forward most packets transparently, so the thermostat should work exactly as it normally would.
The only exception is that unless "Thermostat" is chosen as the temperature source, the packets containing temperature 
data from the thermostat will be intercepted and not sent to the heat pump.

In general the thermostat and microcontroller should play nice; i.e. if you make a change on one, it should be reflected
on the other. The biggest source of conflict is that if the thermostat has a schedule it will still send commands to 
make the unit follow its schedule even if the microcontroller / Home Assistant has sent other commands.
