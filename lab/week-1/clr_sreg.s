.equ SREG, 0x3f       ; Define the address for the SREG register
.org 0                ; Program start address

main:
    ldi r16, 0        ; Load immediate 0 into register r16
    out SREG, r16     ; Output the value of r16 (0) to the SREG register

mainloop:
    rjmp mainloop     ; Infinite loop (jump to mainloop)
