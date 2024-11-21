;==============================================================================
; Assignment 1
; Tasks:
;   1. Display K number (15)
;   2. Display initials (20)
;   3. Display Morse Code (10)
;   4. Odd, even, modulo 5 (15)
;   5. Ping Pong (20)
;==============================================================================
.equ SREG,  0x3f

.equ DDRB,  0x04
.equ PORTB, 0x05

.equ DDRD,  0x0A
.equ PORTD, 0x0B

.org 0

main:
    ; reset system status
    ldi r16, 0
    out SREG, r16

    ; set lower 4 bits of port B to output mode
    ldi r16, 0x0F
    out DDRB, r16

    ; set upper 4  bits of port D to output mode
    ldi r16, 0xF0
    out DDRD, r16

mainloop:
    rcall knumber
    rcall next_task

    rcall initials
    rcall next_task

    rcall morse_code
    rcall next_task

    rcall ping_pong

/******************************************
    1. Display K number: 23151319
 ******************************************/
knumber:
    ldi r22, 100    ; 1s duration

    ldi r24, 2
    rcall display

    ldi r24, 3
    rcall display

    ldi r24, 1
    rcall display

    ldi r24, 5
    rcall display

    ldi r24, 1
    rcall display

    ldi r24, 3
    rcall display

    ldi r24, 1
    rcall display

    ldi r24, 9
    rcall display

    ret

/******************************************
    2. Display initials: 'S.I' in ASCI
 ******************************************/
initials:
    ldi r22, 100    ; 1s duration

    ; display 'S'
    ldi r24, 19
    rcall display

    ; display '.'
    ldi r24, 27
    rcall display

    ; display 'I'
    ldi r24, 9
    rcall display

    ret

/******************************************
    3. Display Morse Code
 ******************************************/
morse_code:
    ldi r16, 1                  ; starting iteration
loop_morse_outer:
    ; is iteration even/odd?
    mov r24, r16
    ldi r22, 2
    rcall mod_div               ; load remainder into r24 (0 = even, 1 = odd)

    cpi r24, 0
    breq display_reverse_morse  ; if even, display reverse

    ; odd iteration - display normal morse
display_normal_morse:
    ; 'S' = ...
    rcall morse_dot
    rcall morse_dot
    rcall morse_dot
    rcall letter_space

    ; 'A' = .-
    rcall morse_dot
    rcall morse_dash
    rcall letter_space

    ; 'K' = -.-
    rcall morse_dash
    rcall morse_dot
    rcall morse_dash
    rjmp check_div_five

display_reverse_morse:
    ; 'K' = -.-
    rcall morse_dash
    rcall morse_dot
    rcall morse_dash
    rcall letter_space

    # ; 'A' = .-
    rcall morse_dot
    rcall morse_dash
    rcall letter_space

    # ; 'S' = ...
    rcall morse_dot
    rcall morse_dot
    rcall morse_dot

check_div_five:
    ; iteration divisible by 5?
    mov r24, r16
    ldi r22, 5
    rcall mod_div
    cpi r24, 0
    brne continue_morse     ; if not divisible by 5, skip

    ; display number 5
    rcall word_space
    ldi r24, 5
    ldi r22, 100            ; 1s duration
    rcall display

continue_morse:
    rcall word_space

    inc r16
    cpi r16, 6             ; 50 iterations
    brne loop_morse_outer
    ret

;-----------------
; Morse Code Utils
;-----------------
morse_dot:
    ldi r24, 1      ; on
    ldi r22, 20     ; for 200ms
    rcall display
    ldi r24, 0      ; off
    ldi r22, 20     ; for 200ms
    rcall display
    ret

morse_dash:
    ldi r24, 1      ; on
    ldi r22, 60     ; for 600ms
    rcall display
    ldi r24, 0      ; off
    ldi r22, 20     ; for 200ms
    rcall display
    ret

letter_space:
    ldi r24, 0      ; off
    ldi r22, 60     ; for 600ms
    rcall display
    ret

word_space:
    ldi r24, 0      ; off
    ldi r22, 140    ; for 1400ms
    rcall display
    ret


/******************************************
    4. Ping-pong
 ******************************************/
ping_pong:
    ldi r22, 100        ; 1s duration
    ldi r19, 0x80       ; start with leftmost LED
forward_loop:
    ; display current position
    mov r24, r19        ; preserve r19 register for shifting
    rcall display

    lsr r19             ; shift right

    cpi r19, 0x00       ; have we reached end?
    brne forward_loop   ; if not, continue shifting right

    ldi r19, 0x02       ; start return with second position (00000010)
backward_loop:
    ; display current position
    mov r24, r19
    rcall display

    lsl r19             ; shift left

    cpi r19, 0x80       ; have we reached start?
    brne backward_loop  ; if not, continue shifting left

    rjmp forward_loop   ; restart

;-----------------------------------------------------------------------------
; Delay - create a delay in 10ms increments
;
; Params:
;   r24 - number of 10ms intervals to delay
;
; Returns: None
;
; Details:
;   * overhead_cycles = 6 (3 push) + 6 (3 pop) = 12 cycles
;   * inner loop = 5 cycles
;   * outer loop = 5 * r17 * r20 = 5 * 250 * 128 + #overhead_cycles
;     ≈ 160,000 cycles
;
;------------------------------------------------------------------------------
delay:
    ; save working registers
    push    r24             ; 2 cycles
    push    r17             ; 2 cycles
    push    r20             ; 2 cycles
    ldi     r17, 250        ; inner loop counter
    ldi     r20, 128        ; middle loop counter
delay_loop:
    nop                     ; 1 cycle
    dec     r17             ; 1 cycle
    cpi     r17, 0          ; 1 cycle
    brne    delay_loop      ; 2 cycles
    ldi     r17, 250        ; reset inner loop
    dec     r20
    cpi     r20, 0
    brne    delay_loop
    ldi     r20, 128        ; reset middle loop
    dec     r24
    cpi     r24, 0
    brne    delay_loop
    ; restore working registers
    pop     r20
    pop     r17
    pop     r24
    ret

;------------------------------------------------------------------------------
; Display - display an 8-bit number to the LEDs for a given duration
;
; Params:
;   r24 - 8-bit number to display
;   r22 - duration to display number
;
; Returns: None
;
;------------------------------------------------------------------------------
display:
    ; display
    out PORTB, r24
    out PORTD, r24
    ; delay
    mov r24, r22        ; copy contents of r22 param to r24 for delay subroutine
    rcall delay
    ret

;------------------------------------------------------------------------------
; Modulus Divsion - perform modulo operation
;
; Params:
;   r24 - dividend (value to be divided)
;   r22 - divisor
;
; Returns:
;   r24 - remainder (result of modulo)
;
; Details:
;   * keep subtracting values till you can't
;
;------------------------------------------------------------------------------
mod_div:
    ; 0 not allowed, error out
    tst     r22
    breq    mod_error
div_loop:
    cp      r24, r22    ; compare dividend with divisor
    brlo    div_done    ; if dividend < divisor, bail
    sub     r24, r22    ; r24 = r24 - r22 => dividend - divisor
    rjmp    div_loop
div_done:
    rjmp    mod_div_complete
mod_error:
    ldi     r24, 0xFF   ; return -1 (unsigned)
mod_div_complete:
    ret


;-------------------------
; Next Task - flash all lights for 2s
;
;-------------------------
next_task:
    ldi r24, 255        ; flash bang
    ldi r22, 200        ; 2s duration
    rcall display
    ret
