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

loop:
    ldi r16, 0x81      ; original value = 10000001

    ; Get lower nybble (0000 0001)
    mov r17, r16
    andi r17, 0x0F     ; Mask lower nybble
    lsl r17
    lsl r17
    lsl r17
    lsl r17            ; Now (0001 0000)

    ; Get upper nybble (1000 0000)
    mov r18, r16
    andi r18, 0xF0     ; Mask upper nybble
    lsr r18
    lsr r18
    lsr r18
    lsr r18            ; Now (0000 1000)

    ; Combine to get 0001 1000 (0x18)
    or r18, r17        ; Result in r18

    ; Write lower 4 bits to PORTB
    mov r16, r18
    andi r16, 0x0F
    out PORTB, r16

    ; Write upper 4 bits to PORTD
    mov r16, r18
    out PORTD, r16

    ; 0.5s delay
    ldi r20, 255
outer_loop:
    ldi r21, 255
inner_loop:
    ldi r22, 20
delay_loop:
    dec r22
    brne delay_loop
    dec r21
    brne inner_loop
    dec r20
    brne outer_loop

    rjmp loop
