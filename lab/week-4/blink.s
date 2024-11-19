; specify equivalent symbols
.equ SREG,0x3f  ; Status register, address 0x3f. See data sheet, p.11
.equ DDRB,0x04  ; Data direction register, address, 0x04. See data sheet, p.11
.equ PORTB,0x05 ; PortB register, register address, 0x05. See data sheet, p.11

; specify the start address
.org 0
; reset system status
main:
        ; Set PB0 (pin 8) to output mode
        ldi r16, 0x01        ; Load 0x01 into r16 (binary 00000001)
        out DDRB, r16        ; Set bit 0 of DDRB to 1 (PB0 is output)

        ldi r16, 0x01        ; Set PB0 high (LED ON)
        out PORTB, r16
        call halfsec         ; Delay for 0.5s

        ldi r16, 0x00        ; Set PB0 low (LED OFF)
        out PORTB, r16
        call halfsec         ; Delay for 0.5s

        rjmp mainloop        ; Infinite loop to keep the program running

; Subroutine for half-second delay
halfsec:
     ldi r18, 100         ; Load 100 into r18 (loop counter)
delay_loop:
     nop                  ; No operation (1 clock cycle)
     dec r18              ; Decrement r18
     cpi r18, 0           ; Compare r18 with 0
     brne delay_loop      ; If r18 is not 0, repeat the loop
     ret                  ; Return from subroutine

mainloop:
        rjmp mainloop       ; Infinite loop to keep the program running
