@-----------------------------------------------------------------------------
@ file: serial.s
@
@ SmegARM UART serial interface driver example.
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
.include "atsame70.i"
@-----------------------------------------------------------------------------
@ Convenience definitions.
@ Reset status transmitter and receiver : Disable transmit and receive.
.equ _RESET,    (_RSTSTA | _TXDIS | _RXDIS | _RSTTX | _RSTRX)
@ Clear reset and disable flags : Enable transmit and receive
.equ _ENABLE,   (_TXEN | _RXEN)
@ Configuration - Normal operation : No parity.
.equ _CONFIG,   (_MODNORMAL | _PARNONE)
@ Reset Interrupts.
.equ _CLRIRQ,   (_RXRDY | _TXRDY | _OVRE | _FRAME | _PARE | _TXEMPTY | _RXCMP)
@ IRQ mask.
.equ _SETIRQ,   (_RXRDY | _TXRDY | _TXEMPTY)
@ Receive only IRQ mask.
.equ _SETRXIRQ, (_RXRDY)
@ Trensmit and receive IRQ mask.
.equ _SETTXIRQ, (_RXRDY | _TXRDY)
@ Trensmit and receive IRQ mask.
.equ _SETTXEIRQ,(_RXRDY | _TXRDY | _TXEMPTY)
@ Clear Tranemit Interrupt
.equ _CLRTXIRQ, (_TXRDY | _TXEMPTY)
@ Clear ERROR mask.
.equ _CLRERR,   (_RSTSTA | _ENABLE)
@ Disable PDC.
.equ _DISPDC,   (_RXTDIS | _TXTDIS)
@-----------------------------------------------------------------------------
@ UART Driver FIFO buffer size.
.equ FIFO_SIZE, 256
@ NVIC instance identifier.
.equ _UARTIRQ,  (1 << _PID_UART0)
@ PMC Peripheral Clock definitions.
.equ _CLOCKSEL, (_PMCPCRCMD | _PID_UART0)
.equ _CLOCKEN,  (_PMCPCREN | _CLOCKSEL)
@ PIO configuration.
.equ _UARTIO,   (_PIO09 | _PIO10)
@-----------------------------------------------------------------------------
.section .bss
@-----------------------------------------------------------------------------
@ Console receive FIFO status.
.global console_rxerr
console_rxerr:
UART_rx_error:  .word   0   @ Receive Error.
rx_in_pnt:      .word   0   @ Receive FIFO input pointer - uint16_t.
rx_out_pnt:     .word   0   @ Receive FIFO output pointer - uint16_t.
@-----------------------------------------------------------------------------
@ Console receive data - shared by interrupt service routine.
.global rx_fifo
rx_fifo:    .space   FIFO_SIZE  @ Receive input buffer - uint8_t[n].
@-----------------------------------------------------------------------------
@ Console transmit FIFO status.
.global console_txerr
console_txerr:
UART_tx_error:  .word   0   @ Transmit error.
tx_in_pnt:      .word   0   @ Transmit FIFO input pointer - uint16_t.
tx_out_pnt:     .word   0   @ Transmit FIFO output pointer - uint16_t.
@-----------------------------------------------------------------------------
@ Console transimt data - shared by interrupt service routine.
.global tx_fifo
tx_fifo:    .space   FIFO_SIZE  @ Transmit output buffer - uint8_t[n].
@-----------------------------------------------------------------------------
.section .text.smeglib
@ Enable Thumb-2 32-bit instructions.
.syntax unified
@-----------------------------------------------------------------------------
@ Console initialize.
@  From C - void console_init(uint32_t)
@  where uint32_t = BAUD rate (precomputed for baud register configuration).
.align
.thumb_func
.func   _console_init
.global _console_init
_console_init:
@ Reset hardware.
    LDR     R2,=(_PERIPHTCR)        @ Peripheral DMA Transfer Control Register.
    LDR     R1,=(_DISPDC)           @ Peripheral DMA Config.
    STR     R1,[R2]                 @ Disable DMA Transfers.
@ Configure UART as console.
    LDR     R2,=(_UART)             @ Point to UART register base.
    LDR     R1,=(_CLRIRQ)           @ Interrupt masks.
    STR     R1,[R2,#_UARTIDRV]      @ Disable ALL interrupt sources.
    LDR     R1,=(_RESET)            @ Disable and reset.
    STR     R1,[R2,#_UARTCRV]       @ Initialize UART.
@ Initialize hardware.
    LDR     R1,=(_CONFIG)           @ Mode and Parity.
    STR     R1,[R2,#_UARTMRV]       @ Configure UART.
    STR     R0,[R2,#_UARTBRGRV]     @ Set UART BAUD rate.
    LDR     R1,=(_ENABLE)           @ TX and RX enable bits.
    STR     R1,[R2,#_UARTCRV]       @ Enable UART transmit and receive.
@ Initialize variables (RAM).
    MOV     R0,#0                   @ Init value (clear).
    LDR     R1,=(UART_rx_error)     @ Receive error variable.
    STR     R0,[R1]                 @ Reset error.
    LDR     R1,=(rx_in_pnt)         @ Receive FIFO input pointer.
    STR     R0,[R1]                 @ Reset index.
    LDR     R1,=(rx_out_pnt)        @ Receiver FIFO output pointer.
    STR     R0,[R1]                 @ Reset index.
    LDR     R1,=(UART_tx_error)     @ Transmit error variable.
    STR     R0,[R1]                 @ Reset error.
    LDR     R1,=(tx_in_pnt)         @ Transmit FIFO input pointer.
    STR     R0,[R1]                 @ Reset index.
    LDR     R1,=(tx_out_pnt)        @ Transmit FIFO output pointer.
    STR     R0,[R1]                 @ Reset index.
@ Enable RX and TX and Interrupts.
    LDR     R1,=(~_SETTXEIRQ)       @ RXRDY IRQ mask.
    STR     R1,[R2,#_UARTIDRV]      @ UnDisable RX Interrupt.
    LDR     R1,=(_SETRXIRQ)         @ RX/TX IRQ mask.
    STR     R1,[R2,#_UARTIERV]      @ Enable RX interrupt.
@ Configure PIOA for UART peripheral.
    LDR     R2,=(_PIOA)             @ Point to PIOA register group.
    MVN     R1,#_UARTIO             @ Peripheral enable bit-mask.
    LDR     R0,[R2,#_PIOABSR1V]     @ Get peripheral configuration 1.
    AND     R0,R1,R0                @ Select Peripheral A.
    STR     R0,[R2,#_PIOABSR1V]     @ Select UART peripheral.
    LDR     R0,[R2,#_PIOABSR2V]     @ Get peripheral configuration 2.
    AND     R0,R1,R0                @ Select Peripheral A.
    STR     R0,[R2,#_PIOABSR2V]     @ Select UART peripheral.
    MOV     R0,#_UARTIO             @ UART0 peripheral enable bit-mask.
    STR     R0,[R2,#_PIOPDRV]       @ Enable UART0 peripheral.
@ Configure PDC UART Clock source.
    LDR     R1,=(_PMCPCDR0)         @ PMC Peripheral Clock Disable Register.
    LDR     R0,=(_UARTIRQ)          @ UART IRQ bit position.
    STR     R0,[R1]                 @ Disable UART clock.
    LDR     R1,=(_PMCPCR)           @ PMC Peripheral Control Register.
    LDR     R0,=(_CLOCKSEL)         @ UART Clock Divisor=1 (0).
    STR     R0,[R1]                 @ Set UART Clock divider.
    LDR     R1,=(_PMCPCER0)         @ PMC Peripheral Clock Enable Register.
    LDR     R0,=(_UARTIRQ)          @ UART IRQ bit position.
    STR     R0,[R1]                 @ Re-Enable UART Clock.
@ Configure NVIC to allow UART interrupts.
    LDR     R1,=(_NVICISER0)        @ NVIC Enable Register address.
    LDR     R0,=(_UARTIRQ)          @ UART IRQ bit position.
    STR     R0,[R1]                 @ Enable UART interrupts.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ Pull uint8_t data from receive FIFO - Returns int -1 on failure.
@  From C - int32_t console_read(void)
@ This is a non-blocking routine - If return != -1 the return value is uint8_t.
.align
.thumb_func
.func   console_read
.global console_read
console_read:
    LDR     R0,=(-1)                @ Default return -1.
    LDR     R3,=(rx_in_pnt)         @ Receive FIFO input vector.
    LDR     R2,[R3]                 @ Receive FIFO input pointer.
    LDR     R3,=(rx_out_pnt)        @ Receive FIFO output vector.
    LDR     R1,[R3]                 @ Receive FIFO output pointer.
    CMP     R2,R1                   @ Check for available slot.
    BEQ     .rx_empty               @ FIFO empty.
    LDR     R3,=(rx_fifo)           @ Get RX FIFO pointer.
    LDRB    R0,[R3,R1]              @ Pull byte from FIFO.
    ADD     R1,#1                   @ Increment FIFO output pointer.
    LDR     R2,=(FIFO_SIZE)         @ FIFO limit.
    CMP     R2,R1                   @ Check for overflow.
    BNE     .rx_no_ov               @ Still linear.
    MOV     R1,#0                   @ Overflow: Wrap circular buffer.
.rx_no_ov:
    LDR     R3,=(rx_out_pnt)        @ Receive FIFO output Vector.
    STR     R1,[R3]                 @ Update FIFO output pointer.
    UXTB    R0,R0                   @ Return byte only.
.rx_empty:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ Push uint8_t data to transmit FIFO - Returns int16_t -1 on failure.
@  From C - int32_t console_write(uint8_t)
@ This is a non-blocking routine - Returns -1 on error otherwise 0.
.align
.thumb_func
.func   console_write
.global console_write
console_write:
    PUSH    {R4,LR}                 @ Save working registers.
    LDR     R3,=(tx_in_pnt)         @ Transmit FIFO input vector.
    LDR     R2,[R3]                 @ Transmit FIFO input pointer.
    MOV     R4,R2                   @ Original index needed later.
    LDR     R1,=(FIFO_SIZE)         @ FIFO limit.
    ADD     R2,#1                   @ Point to next slot.
    CMP     R2,R1                   @ Check for overflow.
    BNE     .tx_no_ov               @ Still linear.
    MOV     R2,#0                   @ Overflow: Wrap circular buffer.
.tx_no_ov:
    LDR     R3,=(tx_out_pnt)        @ Transmit FIFO output vector.
    LDR     R1,[R3]                 @ Transmit FIFO output pointer.
    CMP     R2,R1                   @ Check FIFO slot available.
    BEQ     .tx_full                @ FIFO full return error.
    LDR     R3,=(tx_in_pnt)         @ Transmit FIFO input vector.
    STR     R2,[R3]                 @ Update FIFO input pointer.
    LDR     R3,=(tx_fifo)           @ Output FIFO vector.
    STRB    R0,[R3,R4]              @ Push byte to FIFO.
    LDR     R3,=(_UART)             @ Base address for UART register set.
    LDR     R1,=(_SETTXEIRQ)        @ Transmit Interrupt Disable mask.
    STR     R1,[R3,#_UARTIERV]      @ Disable transmit interrupt.
    MOV     R0,#0                   @ Success.
    B       .tx_rtn                 @ Exit.
.tx_full:
    LDR     R0,=(-1)                @ Error: Return FIFO full.
.tx_rtn:
    POP     {R4,PC}                 @ Restore registers and return.
.endfunc
.align
@-----------------------------------------------------------------------------
.section .text.smegisr
@-----------------------------------------------------------------------------
@ UART Interrupt Service Routine.
.align
.thumb_func
.func   __uart0_handler
.global __uart0_handler
__uart0_handler:
    PUSH    {R3-R4,LR}              @ Save working registers.
    LDR     R4,=(_UART)             @ Base address for UART register set.
    LDR     R0,[R4,#_UARTSRV]       @ Get Interrupt status.
    MOV     R1,#_TXRDY              @ Transmit interrupt flag.
    ANDS    R0,R1                   @ Check if transmit interrupt.
    BEQ     .uart_irx               @ Try receive interrupt.
.uart_itx:
    LDR     R3,=(tx_in_pnt)         @ Transmit FIFO input Vector.
    LDR     R1,[R3]                 @ Transmit FIFO input pointer.
    LDR     R3,=(tx_out_pnt)        @ Transmit FIFO output pointer.
    LDR     R2,[R3]                 @ Transmit FIFO output pointer.
    CMP     R2,R1                   @ Check if FIFO slot available.
    BNE     .itx_push               @ Push slot to UART.
    LDR     R1,=(_CLRTXIRQ)         @ Transmit Interrupt Disable mask.
    STR     R1,[R4,#_UARTIDRV]      @ Disable transmit interrupt.
    B       .uart_irx               @ Try receive interrupt.
.itx_push:
    LDR     R1,=(tx_fifo)           @ Transmit fifo base vector.
    LDRB    R0,[R1,R2]              @ Get next slot data.
    STR     R0,[R4,#_UARTTHRV]      @ Push data to transmitter.
    ADD     R2,#1                   @ Increment transmit FIFO output pointer.
    LDR     R1,=(FIFO_SIZE)         @ Get FIFO length.
    CMP     R2,R1                   @ Check for overflow.
    BNE     .itx_no_ov              @ Still linear.
    MOV     R2,#0                   @ Wrap circular buffer.
.itx_no_ov:
    STR     R2,[R3]                 @ Update transmit FIFO output pointer.
    LDR     R1,=(_SETTXIRQ)         @ Transmit Interrupt Disable mask.
    STR     R1,[R4,#_UARTIERV]      @ Disable transmit interrupt.
.uart_irx:
    LDR     R0,[R4,#_UARTSRV]       @ Get Interrupt status.
    MOV     R1,#_RXRDY              @ Receive interrupt flag.
    ANDS    R1,R0                   @ Check receive interrupt.
    BEQ     .uart_irtn              @ No receiver interrput pending.
    LDR     R3,=(rx_out_pnt)        @ Receive FIFO output vector.
    LDR     R1,[R3]                 @ Receive FIFO output pointer.
    LDR     R3,=(rx_in_pnt)         @ Receive FIFO input vector.
    LDR     R2,[R3]                 @ Receive FIFO input pointer.
    LDR     R0,=(FIFO_SIZE)         @ Get FIFO length.
    ADD     R2,#1                   @ Point to nets FIFO slot.
    CMP     R2,R0                   @ Check for overflow.
    BNE     .irx_no_ov              @ Still linear.
    MOV     R2,#0                   @ Wrap circular buffer.
.irx_no_ov:
    CMP     R2,R1                   @ Check if FIFO slot available.
    BEQ     .uart_irtn              @ Overflow: Ignore.
    LDR     R1,[R3]                 @ Current FIFO slot.
    STR     R2,[R3]                 @ Update FIFO input pointer.
    LDR     R2,=(rx_fifo)           @ Receive FIFO vector.
    LDR     R0,[R4,#_UARTRHRV]      @ Pull data from receiver.
    STRB    R0,[R2,R1]              @ Push data to receive FIFO.
.uart_irtn:
    POP     {R3-R4,PC}              @ Restore working registers.
.endfunc
.align
@-----------------------------------------------------------------------------
.end
@------------------------------------------------------------------------------
@ end: serial.s
