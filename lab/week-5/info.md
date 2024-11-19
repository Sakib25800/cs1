| LED bit | PORT PIN | Arduino Pin |
|---------|----------|-------------|
| 0       | PB0      | D8          |
| 1       | PB1      | D9          |
| 2       | PB2      | D10         |
| 3       | PB3      | D11         |
| 4       | PD4      | D4          |
| 5       | PD5      | D5          |
| 6       | PD6      | D6          |
| 7       | PD7      | D6          |


| Mnemonics | Operands | Description             | Operation                     | Flags           | #Clocks |
|-----------|----------|-------------------------|-------------------------------|-----------------|---------|
| LSL       | Rd       | Logical Shift Left      | Rd(n+1) ← Rd(n), Rd(0) ← 0    | Z,C,N,V         | 1       |
| LSR       | Rd       | Logical Shift Right     | Rd(n) ← Rd(n+1), Rd(7) ← 0    | Z,C,N,V         | 1       |
