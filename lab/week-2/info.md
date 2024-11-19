| PORTB Bit | Atmega328 Pin | Arduino Nano Digital Pin  |
|-----------|---------------|---------------------------|
| 0         | PB0           | D8                        |
| 1         | PB1           | D9                        |
| 2         | PB2           | D10                       |
| 3         | PB3           | D11                       |

SREG Address:
- Data: 0x3F
- I/O: 0x5F

PORTB Address:
- Data: 0x05
- I/O: 0x25

DDRB Address:
- Data: 0x04
- I/O: 0x24

CPU communicates with PORT B via the databus
