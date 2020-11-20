@-----------------------------------------------------------------------------
@ file: led.s
@
@ SmegARM GPIO 7-Segment LED Display driver example.
@
@ Copyright (c) 2020 - Dysfunctional Farms A.K.A. www.smegware.com
@
@  All Smegware software is free; you can redistribute it and/or modify
@  it under the terms of the GNU General Public License as published by
@  the Free Software Foundation; either version 2 of the License, or
@  (at your option) any later version.
@
@  This software is distributed in the hope that it will be useful,
@  but WITHOUT ANY WARRANTY; without even the implied warranty of
@  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
@  GNU General Public License for more details.
@
@-----------------------------------------------------------------------------
@
@ History...
@
@   $Source$
@   $Author$
@ $Revision$
@
@ $Log$
@-----------------------------------------------------------------------------
@         _____
@  And:  |  A  |
@       F|     |B
@        |_____|
@        |  G  |
@       E|     |C
@        |_____|
@           D  -(DP)
@
@ Additionally: Each cathode segment is limited through a 464-ohm resistor.
@             : Each digit is buffered with a 2N2907 PNP transistior which
@             :  inverts the logic for the common anode digit drive.
@-----------------------------------------------------------------------------
.include "atsame70.i"
@-----------------------------------------------------------------------------
@ Power Management Controller PIOC and Timer 0 setup.
.equ _PMC_PIOA,   (_PID_PIOA | _PMCGCLKEN | _PMCPCRCMD | _PMCPCREN | _PMCCLKGCSSMCLK)
.equ _PMC_TC0,    (_PID_TC00 | _PMCGCLKEN | _PMCPCRCMD | _PMCPCREN | _PMCCLKGCSSMCLK)
@ Timer 0 configurations.
.equ  _TC0_CTRL,  (_SWTRG | _CLKEN)
.equ  _TC0_MODE,  (_TCLK2 | _WAVE)    @ TC2_CLK = MCLK / 8 on SAME70.
.equ  _TC0_IRQ,   (_CPCS)
@-----------------------------------------------------------------------------
@ LED Digit/Segment PIO mapping definitions.
.equ  _SEG_A,     _PIO13    @ Segment-A - PIOA-13.
.equ  _SEG_B,     _PIO14    @ Segment-B - PIOA-14.
.equ  _SEG_C,     _PIO15    @ Segment-C - PIOA-15.
.equ  _SEG_D,     _PIO16    @ Segment-D - PIOA-16.
.equ  _SEG_E,     _PIO17    @ Segment-E - PIOA-17.
.equ  _SEG_F,     _PIO18    @ Segment-F - PIOA-18.
.equ  _SEG_G,     _PIO19    @ Segment-G - PIOA-19.
.equ  _SEG_DP,    _PIO20    @ Segment-DP - PIOA-20.
.equ  _DIG_1,     _PIO00    @ Digit-1 - PIOA-00 (MSD).
.equ  _DIG_2,     _PIO01    @ Digit-2 - PIOA-01.
.equ  _DIG_3,     _PIO02    @ Digit-3 - PIOA-02.
.equ  _DIG_4,     _PIO03    @ Digit-4 - PIOA-03.
.equ  _DIG_5,     _PIO04    @ Digit-5 - PIOA-04.
.equ  _DIG_6,     _PIO05    @ Digit-6 - PIOA-05.
.equ  _DIG_7,     _PIO11    @ Digit-7 - PIOA-11.
.equ  _DIG_8,     _PIO12    @ Digit-8 - PIOA-12 (LSD).
@ PIOC LED IO.
.equ  _LED_SEGS,  (_SEG_A | _SEG_B | _SEG_C | _SEG_D | _SEG_E | _SEG_F | _SEG_G | _SEG_DP)
.equ  _LED_DIGS,  (_DIG_1 | _DIG_2 | _DIG_3 | _DIG_4 | _DIG_5 | _DIG_6 | _DIG_7 | _DIG_8)
.equ  _LED_PIOS,  (_LED_SEGS | _LED_DIGS)
@ Number definitions 0 - 9.
.equ  _NUM_ZERO,  (_SEG_A | _SEG_B | _SEG_C | _SEG_D | _SEG_E | _SEG_F)
.equ  _NUM_ONE,   (_SEG_B | _SEG_C)
.equ  _NUM_TWO,   (_SEG_A | _SEG_B | _SEG_D | _SEG_E | _SEG_G)
.equ  _NUM_THREE, (_SEG_A | _SEG_B | _SEG_C | _SEG_D | _SEG_G)
.equ  _NUM_FOUR,  (_SEG_B | _SEG_C | _SEG_F | _SEG_G)
.equ  _NUM_FIVE,  (_SEG_A | _SEG_C | _SEG_D | _SEG_F | _SEG_G)
.equ  _NUM_SIX,   (_SEG_C | _SEG_D | _SEG_E | _SEG_F | _SEG_G)
.equ  _NUM_SEVEN, (_SEG_A | _SEG_B | _SEG_C)
.equ  _NUM_EIGHT, (_SEG_A | _SEG_B | _SEG_C | _SEG_D | _SEG_E | _SEG_F | _SEG_G)
.equ  _NUM_NINE,  (_SEG_A | _SEG_B | _SEG_C | _SEG_F | _SEG_G)
@ Misc LED definitions.
.equ  _NUM_DIGITS,  8         @ Number of display digits.
.equ  _MAX_NUMBER,  9         @ Maximum number.
@ Timer 0 rate definitions.
.equ  _MUXRATE,     800       @ 800 Hz scan rate.
.equ  _TC0_PERIOD,  ((SYSTEMCLK / 8) / _MUXRATE)
.equ  _TC0_WIDTH,   (_TC0_PERIOD / 2)
@-----------------------------------------------------------------------------
.section .text.smegconst
@-----------------------------------------------------------------------------
.align
led_numbers:
      .long   _NUM_ZERO
      .long   _NUM_ONE
      .long   _NUM_TWO
      .long   _NUM_THREE
      .long   _NUM_FOUR
      .long   _NUM_FIVE
      .long   _NUM_SIX
      .long   _NUM_SEVEN
      .long   _NUM_EIGHT
      .long   _NUM_NINE
led_digits:
      .long   _DIG_1
      .long   _DIG_2
      .long   _DIG_3
      .long   _DIG_4
      .long   _DIG_5
      .long   _DIG_6
      .long   _DIG_7
      .long   _DIG_8
@-----------------------------------------------------------------------------
.section .bss
@-----------------------------------------------------------------------------
.global digit_array
digit_array:      .space  _NUM_DIGITS     @ Digit character array.
digit_position:   .long   0               @ Multiplexing digit position.
@-----------------------------------------------------------------------------
.section .text.smeglib
@-----------------------------------------------------------------------------
@ LED PIO initialize.
@  From C - void led_init(void)
.align
.thumb_func
.func   led_init
.global led_init
led_init:
@ Configure the PMC clock for the PIOA.
    LDR     R1,=(_PMCPCR)           @ PMC Peripheral Control Register.
    LDR     R0,=(_PMC_PIOA)         @ PIOC clock configuration.
    STR     R0,[R1]                 @ Configure PIOC input clock.
@ Configure the PMC clock for Timer-0.
    LDR     R1,=(_PMCPCR)           @ PMC Peripheral Control Register.
    LDR     R0,=(_PMC_TC0)          @ TC0 clock configuration.
    STR     R0,[R1]                 @ Configure TC0 input clock.
@ Configure PIOC LED I/O.
    LDR     R2,=(_PIOA)             @ PIOA Register Group base address.
    LDR     R0,=(_LED_PIOS)         @ LED PIO I/O bits.
    STR     R0,[R2,#_PIOIDRV]       @ Disable interrupts on LED I/O bits.
    STR     R0,[R2,#_PIOSODRV]      @ Turn all LED segments/digits off.
    STR     R0,[R2,#_PIOPUDRV]      @ Disable pullups for LED I/O outputs.
    STR     R0,[R2,#_PIOPERV]       @ Enable PIOC LED I/O bits.
    STR     R0,[R2,#_PIOOERV]       @ Enable PIOC LED I/O bits as outputs.
@ Initialize the LED digit array.
    LDR     R2,=(digit_array)       @ Point to digit array.
    MOV     R1,#0                   @ Array digit counter.
    MOV     R0,#0                   @ Set digit to Zero.
.dig_set:
    STRB    R0,[R2,R1]              @ Initialize array data.
    ADD     R1,#1                   @ Loop counter.
    CMP     R1,#_NUM_DIGITS         @ Check loop limit.
    BLT     .dig_set                @ Continue initialization.
    LDR     R2,=(digit_position)    @ Digit multiplexing position.
    STR     R0,[R2]                 @ Reset digit position.
@ Configure Timer 0 for multiplexing digits.
    LDR     R2,=(_TC0_0)            @ TC0 Register Group base address.
    LDR     R1,=(_TC0_MODE)         @ TC0 configuration.
    STR     R1,[R2,#_TCCMRV]        @ Set TC0 mode.
    LDR     R1,=(_TC0_PERIOD)       @ TC0 period value.
    STR     R1,[R2,#_TCRCV]         @ Set TC0 period.
    LDR     R1,=(_TC0_WIDTH)        @ TC0 clock width.
    STR     R1,[R2,#_TCRAV]         @ Set TC0 waveform width.
    LDR     R1,=(_TC0_IRQ)          @ TC0 condition interrupt.
    STR     R1,[R2,#_TCIERV]        @ Enable TC0 interrupt.
    LDR     R1,=(_TC0_CTRL)         @ TC0 control configuration.
    STR     R1,[R2,#_TCCCRV]        @ Enable/Start TC0.
@ Configure NVIC to allow TC0 interrupts.
    LDR     R1,=(_NVICISER0)        @ NVIC Enable Register address.
    LDR     R0,=(1 << _PID_TC00)    @ TC0 IRQ bit position.
    STR     R0,[R1]                 @ Enable TC0 interrupts.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ Set LED digit.
@  From C - int32_t led_set_digit(uint32_t digit, uint32_t number)
@    Returns 0 on success : -1 on error (number/digit out of range).
.align
.thumb_func
.func   led_set_digit
.global led_set_digit
led_set_digit:
    CMP     R0,#_NUM_DIGITS         @ Range check digit.
    BGE     .set_err                @ Digit out of range.
    CMP     R1,#_MAX_NUMBER         @ Range check number.
    BGT     .set_err                @ Number out of range.
@ Store number at digit position.
    LDR     R2,=(digit_array)       @ Point to numeric digit buffer.
    STRB    R1,[R2,R0]              @ Set digit.
    MOV     R0,#0                   @ Return ok.
    B       .set_rtn                @ Exit.
.set_err:
    LDR     R0,=(-1)                @ Return error.
.set_rtn:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ Set LED digit.
@  From C - int32_t led_set_digit(uint32_t digit)
@    Returns 0 on success : -1 on error (digit out of range).
.align
.thumb_func
.func   led_clear_digit
.global led_clear_digit
led_clear_digit:
    CMP     R0,#_NUM_DIGITS         @ Range check digit.
    BGE     .clr_err                @ Digit out of range.
@ Store number at digit position.
    LDR     R2,=(digit_array)       @ Point to numeric digit buffer.
    MOV     R0,#10                  @ Out of range number will blank digit.
    STRB    R1,[R2,R0]              @ Set digit.
    MOV     R0,#0                   @ Return ok.
    B       .clr_rtn                @ Exit.
.clr_err:
    LDR     R0,=(-1)                @ Return error.
.clr_rtn:
    BX      LR                      @ Return.
.endfunc
.align
@-----------------------------------------------------------------------------
.section .text.smegisr
@-----------------------------------------------------------------------------
@ LED Digit Multiplexing Timer-0 Interrupt Service Routine.
.align
.thumb_func
.func   __tc0_0_handler
.global __tc0_0_handler
__tc0_0_handler:
    PUSH    {LR}                    @ Save working registers.
@ Reset Interrupt status.
    LDR     R2,=(_TC0_0)            @ Point to Timer-0 control block.
    LDR     R0,[R2,#_TCSRV]         @ Read/Reset Interrupt status.
@ Restart Timer.
    LDR     R0,=(_TC0_CTRL)         @ Timer restart command.
    STR     R0,[R2,#_TCCCRV]        @ Restart timer.
@ Increment digit mux index.
    LDR     R2,=(digit_position)    @ Digit multiplex position.
    LDR     R0,[R2]                 @ Get current digit.
    ADD     R0,#1                   @ Point to next digit.
    CMP     R0,#_NUM_DIGITS         @ Check range.
    BLT     .nxt_dgt                @ Still in range.
    MOV     R0,#0                   @ Reset digit position.
.nxt_dgt:
    STR     R0,[R2]                 @ Update digit position counter.
@ Update Digits/Segments.
    PUSH    {R0}                    @ Save digit index.
    LSL     R0,#2                   @ Convert byte index to long.
    LDR     R2,=(_PIOA)             @ PIOC Register Group base address.
    LDR     R1,=(_LED_PIOS)         @ LED PIO I/O bits.
    STR     R1,[R2,#_PIOSODRV]      @ Turn all LED segments/digits off.
    LDR     R1,=(led_digits)        @ Point to LED Digit array.
    LDR     R1,[R1,R0]              @ Get current digit.
    STR     R1,[R2,#_PIOCODRV]      @ Enable current digit.
    POP     {R0}                    @ Restore Original digit index.
    LDR     R1,=(digit_array)       @ Point to LED Digit number values.
    LDRB    R0,[R1,R0]              @ Get current number.
    CMP     R0,#_MAX_NUMBER         @ Range check.
    BGT     .bad_nmbr               @ Number out of range.
    LSL     R0,#2                   @ Convert byte index to long.
    LDR     R1,=(led_numbers)       @ Point to number Segment array.
    LDR     R1,[R1,R0]              @ Convert number to segments.
    STR     R1,[R2,#_PIOCODRV]      @ Turn on current number segments.
.bad_nmbr:
    POP     {PC}                    @ Return.
.endfunc
.align
@-----------------------------------------------------------------------------
.end
@------------------------------------------------------------------------------
@ end: led.s
