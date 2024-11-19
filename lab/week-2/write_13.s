; write_13.s  - Turns on 1/4 LEDs and set bits 0-3 of DDRB to output mode

; specify equivalent symbols
.equ SREG,0x3f  ; Status register, address 0x3f. See data sheet, p.11
.equ DDRB,0x04  ; Data direction register, address, 0x04. See data sheet, p.11
.equ PORTB,0x05 ; PortB register, register address, 0x05. See data sheet, p.11

; specify the start address
.org 0
; reset system status
main:       ldi r16,0       ; set register r16 to zero
            out SREG,r16    ; copy contents of r16 to SREG, i.e., clear SREG

            ldi r16,0x0F    ; set register r16 to 0x0F = 0b00001111
            out DDRB,r16    ; copy contents of r16 to DDRB, i.e., set bits 0-3 of DDRB to output mode

            ldi r16,0x8    ; set register r16 to 0x0D = 0b1000
            out PORTB,r16   ; copy contents of r16 to PORTB, i.e., set bit of PORTB to LED on

mainloop:    rjmp mainloop   ; jump back to mainloop address
