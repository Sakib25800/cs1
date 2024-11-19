| PORTC Bit | Atmega328 Pin | Arduino Nano Digital Pin  |
|-----------|---------------|---------------------------|
| 0         | PC0           | A0                        |
| 1         | PC1           | A0                        |
| 2         | PC2           | A0                       |
| 3         | PC3           | A0                       |

PORTC Address:
- Space: 0x08
- I/O: 0x28

DDRC Address:
- Space: 0x07
- I/O: 0x27

PINC Address:
- Space: 0x06
- I/O: 0x26

| Mnemonics | Operands | Description             | Operation     | Flags           | #Clocks |
|-----------|----------|-------------------------|---------------|-----------------|---------|
| IN        | Rd, A    | In From I/O Location    | Rd ← I/O(A)   | None            | 1       |
| OUT       | A, Rr    | Out To I/O Location     | I/O(A) ← Rr   | None            | 1       |
| ADD       | Rd, Rr   | Add without Carry       | Rd ← Rd + Rr  | Z, C, N, V, S, H | 1       |
| SUB       | Rd, Rr   | Subtract without Carry  | Rd ← Rd - Rr  | Z, C, N, V, S, H | 1       |
| CPI       | Rd, K    | Compare with Immediate  | Rd - K        | Z, C, N, V, S, H | 1       |
| BRLO      | k        | Branch if Lower         | if (C = 1) then PC ← PC + k + 1 | None | 1 / 2 |
