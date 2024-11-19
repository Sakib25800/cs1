Answers
1. 20MHz
2. 16MHz
3. 16 million cycles per second
4. NOP = 1 cycle
5. Per cycle = 1 / 16mill = time to execute NOP
6. 0x01 = 0b0001 so last LED turns toggles
```assembly
        ldi r17, 100
loop:   nop
        dec r17
        cpi r17, 0
        brne loop
```
7. 8 million times
8. 100 times
