; read_portc.s - reads value from PORTC and writes to PORTB

; specify equivalent symbols
.equ SREG, 0x3f    ; Status register
.equ DDRB, 0x04    ; Data Direction Register for PORTB
.equ PORTB, 0x05   ; Address of PORTB
.equ DDRC, 0x07    ; Data Direction Register for PORTC
.equ PINC, 0x06    ; Address of input register for PORTC

; specify the start address
.org 0  ; reset system status
main:   ldi r16, 0      ; set register r16 to zero
        out SREG, r16   ; clear SREG.

        ; configure PORTB for output
        ldi r16, 0x0F   ; configure bits 0 to 3 of PORTB as output
        out DDRB, r16   ; writes r16 to DDRB

        ; configure PORTC for input
        ldi r16, 0x0F   ; configure bits 0-3 of PORTC as input
        out DDRC, r16   ; writes r16 to DDRC to configure port direction

        ; reads from external pins of PORTC to r16
        in r16, PINC    ; read PINC into r16
        out PORTB, r16  ; write contents of r16 to PORTB (i.e., drive LEDs)

mainloop: rjmp mainloop ; infinite loop to keep the program running
