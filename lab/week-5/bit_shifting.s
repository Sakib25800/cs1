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

        ; set lower 4 bits of PORTB to output mode
        ldi r16, 0x0F
        out DDRB, r16

        ; set upper 4 bits of PORTD to output mode
        ldi r16, 0xF0
        out DDRD, r16

start_pattern:
        ldi r20, 0x55   ; initial pattern value
        out PORTB, r20
        out PORTD, r20
        rcall delay_half_sec

        ; shift left
        lsl r20
        out PORTB, r20
        out PORTD, r20
        rcall delay_half_sec

        ; shift right
        rsl r20
        out PORTB, r20
        out PORTD, r20
        rcall delay_half_sec

        rjmp start_pattern

delay_half_sec:
        ldi r24, 31
outer_loop:
        ldi r22, 0xFF
middle_loop:
        ldi r23, 0xFF
inner_loop:
        dec r23
        brne inner_loop
        dec r22
        brne middle_loop
        dec r24
        brne outer_loop
        ret
