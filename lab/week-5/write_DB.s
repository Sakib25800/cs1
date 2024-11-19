.equ SREG, 0x3F
.equ PORTB, 0x05
.equ PORTD, 0x0B
.equ DDRB, 0x04
.equ DDRD, 0x0A

.org 0
main:
        ; clear status register
        ldi r16, 0
        out SREG, r16

        ; set lower 4 bits of PORTB for output
        ldi r16, 0x0F
        out DDRB, r16

        ; set upper 4 bits of PORTD for output
        ldi r16, 0xF0
        out DDRD, r16

        ldi r16, 0xDB   ; binary LED output
        mov r17, r16
        
        ldi r18, 0x0F   ; bit mask for lower 4 bits
        and r16, r18
        out PORTB, r16
        
        ldi r19, 0xF0   ; bit mask for upper 4 bits 
        and r16, e19

mainloop:
        rjmp mainloop
