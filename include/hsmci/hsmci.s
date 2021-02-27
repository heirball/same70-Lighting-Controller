@-----------------------------------------------------------------------------
@ file: hsmci.s
@
@ SmegARM ATSAME70 HSMCI interface driver example.
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
@ Power Management Controller WDT setup.
.equ _PMC_HSMCI,      (_PID_HSMCI | _PMCPCRCMD | _PMCPCREN)
@ Power Management Controller WDT setup.
.equ _NVIC_HSMCI,     (1 << _PID_HSMCI)
@-----------------------------------------------------------------------------
@ GMAC Pin Definitions.
.equ  _HSMCIIO,   _PIOA         @ HSMCI is on Port-A.
.equ  _MCCK,      _PIO25        @ Data transfer clock.
.equ  _MCDA2,     _PIO26        @ Data bit 2.
.equ  _MCDA3,     _PIO27        @ Data bit 3.
.equ  _MCCDA,     _PIO28        @ Data/Address control.
.equ  _MCDA0,     _PIO30        @ Data bit 0.
.equ  _MCDA1,     _PIO31        @ Data bit 1.
.equ  _MCIBITSC,  (_MCCDA | _MCDA0 | _MCDA1 | _MCDA2 | _MCDA3) @ Peripheral C.
.equ  _MCIBITSD,  _MCCK                                        @ Peripheral D.
.equ  _MCIBITS,   (_MCIBITSC | _MCIBITSD)
.equ  _DTOR,      (_MCIDTM1048576 | 2)
.equ  _CSTOR,     (_MCIDTM1048576 | 2)
.equ  _CFG,       (_MCIFIFOMODE | _MCIFERRCTRL)
.equ  _BLOCKSZ,   512
.equ  _BLOCKCNT,  0
.equ  _BLOCKLEN,  ((_BLOCKSZ << 16) | _BLOCKCNT)
.equ  _SDIO,      (_MCISDCSELA | _MCISDCBUS1)
.equ  _400KHZ,    300000        @ 400000 doesn't work on this hardware.
.equ  _CLKDIV,    ((((SYSTEMCLK / 2) / _400KHZ) + 3) & _MCICLKDIVMSK)
.equ  _PWSDIV,    ((0X07 << 8) & _MCIPWSDIVMSK)
.equ  _MR1,       (_MCICLKODD | _PWSDIV | _CLKDIV)
.equ  _MR2,       (_MCIRDPROOF | _MCIWRPROOF)
@.equ  _CR,        (_MCIEN | _MCIPWSEN)
.equ  _CR,        (_MCIEN)
.equ  _SNDCLK,    (_MCIRDPROOF | _MCIWRPROOF | _MCIFBYTE)
.equ  _WRSTRT,    (_MCIRSPNONE | _MCISPCINIT | _MCIOPDCMD)
.equ  _RDWRPROOF, (_MCIRDPROOF | _MCIRDPROOF)
.equ  _RSPERR,    (_MCIRTOE | _MCIRENDE | _MCIRDIRE | _MCIRINDE)
@-----------------------------------------------------------------------------
.section .bss
@-----------------------------------------------------------------------------
.section .text.smeglib
@ Enable Thumb-2 32-bit instructions.
.syntax unified
@-----------------------------------------------------------------------------
@ HSMCI initialize.
@  From C - void hsmci_init(void)
.align
.thumb_func
.func   hsmci_init
.global hsmci_init
hsmci_init:
@ Enable HSMCI on PIOA Peripheral C/D.
    LDR     R2,=(_HSMCIIO)          @ HSMCI PIO Register Group base address.
    LDR     R1,=(_MCIBITS)          @ HSMCI PIO peripheral select bit-mask.
    STR     R1,[R2,#_PIOPUERV]      @ Enable PullUps on I/O pins.
    STR     R1,[R2,#_PIOPDRV]       @ Enable peripheral control.
    LDR     R0,[R2,#_PIOABSR2V]     @ Current peripheral C/D config.
    ORR     R0,R1,R0                @ Select peripheral C/D.
    STR     R0,[R2,#_PIOABSR2V]     @ Update peripheral AB/CD config.
    LDR     R1,=(~_MCIBITSC)        @ HSMCI PIO peripheral C bit-mask.
    LDR     R0,[R2,#_PIOABSR1V]     @ Current peripheral A/B config.
    AND     R0,R1,R0                @ Select peripheral C.
    LDR     R1,=(_MCIBITSD)         @ HSMCI PIO peripheral D bit- mask.
    ORR     R0,R1,R0                @ Select peripheral D.
    STR     R0,[R2,#_PIOABSR1V]     @ Upadte peripheral AB/CD config.
@ Configure the PMC clock for the HSMCI.
    LDR     R1,=(_PMCPCER0)
    LDR     R0,=(1 << _PID_HSMCI)
    STR     R0,[R1]                 @ Configure HSMCI clock.
@ Initialize and configure HSMCI.
    LDR     R2,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,=(_MCIWPKEY)         @ Write Protect Key (PASSWD).
    STR     R0,[R2,#_MCIWPMRV]      @ Disable write protect.
    MOV     R0,#_MCISWRST           @ HSMCI Reset flag.
    STR     R0,[R2,#_MCICRV]        @ Reset the HSMCI module.
    MOV     R0,#_DTOR               @ Data timeout config.
    STR     R0,[R2,#_MCIDTORV]      @ Configure HMCI data timeout.
    STR     R0,[R2,#_MCICSTORV]     @ Configure HMCI completion signal timeout.
    MOV     R0,#_CFG                @ HSMCI Initial configuration.
    STR     R0,[R2,#_MCICFGV]       @ Configure FIFO and Flow control.
    LDR     R0,=(_BLOCKLEN)         @ Block length/count configuration.
    STR     R0,[R2,#_MCIBLKRV]      @ Configure Block size.
    MOV     R0,#_SDIO               @ SD I/O mode.
    STR     R0,[R2,#_MCISDCRV]      @ Configure SD I/O mode.
    LDR     R0,=(_MR1)              @ Mode configuration.
    STR     R0,[R2,#_MCIMRV]        @ Set initial mode.
    LDR     R0,=(_CR)               @ Control configuration.
    STR     R0,[R2,#_MCICRV]        @ Set initial control.
    LDR     R0,=(_MR2)              @ Mode configuration.
    LDR     R1,[R2,#_MCIMRV]        @ Get durrent mode.
    ORR     R0,R1,R0                @ Enable additional modes.
    STR     R0,[R2,#_MCIMRV]        @ Set final mode.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI send dummy clocks to wake up card.
@  From C - void hsmci_send_clock(void)
.align
.thumb_func
.func   hsmci_send_clock
.global hsmci_send_clock
hsmci_send_clock:
    PUSH    {LR}                    @ Preserve necessary to call pause().
    LDR     R2,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R1,=(~_SNDCLK)          @ Mode Register mask setup.
    LDR     R0,[R2,#_MCIMRV]        @ Get current Mode Register.
    AND     R0,R1,R0                @ Disable WRPROOF | RDPROOF | FBYTE.
    STR     R0,[R2,#_MCIMRV]        @ Update Mode Register.
    MOV     R0,#0                   @ Write Argument.
    STR     R0,[R2,#_MCIARGRV]      @ Set command argument.
    LDR     R0,=(_WRSTRT)           @ Initialization Clock command.
    STR     R0,[R2,#_MCICMDRV]      @ Send dummy clocks to wake up card.
.hsc_nrdy:
    BL      pause
    LDR     R2,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R2,#_MCISRV]        @ Get status.
    ANDS    R0,#_MCICMDRDY          @ Check command ready state.
    BEQ     .hsc_nrdy               @ Command not ready.
    POP      {PC}                   @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI get response.
@  From C - uint32_t hsmci_get_response(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_get_response
.global hsmci_get_response
hsmci_get_response:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCIRSPRV]      @ Return response.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI get status.
@  From C - uint32_t hsmci_get_status(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_get_status
.global hsmci_get_status
hsmci_get_status:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCISRV]        @ Return status.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI set mode.
@  From C - void hsmci_set_mode(uint32_t)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_set_mode
.global hsmci_set_mode
hsmci_set_mode:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    STR     R0,[R1,#_MCIMRV]        @ Set mode.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI get mode.
@  From C - uint32_t hsmci_get_mode(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_get_mode
.global hsmci_get_mode
hsmci_get_mode:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCIMRV]        @ Return mode.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI send command with argument.
@ Multiple command types.
@  bc	  : broadcast command, no response.
@  br	  : broadcast command with response.
@  ac	  : addressed command (point to point); No data transfer on DAT.
@  adtc : addressed data transfer command	Data transfer on DAT.
@
@  From C - int hsmci_send_command(uint32_t command, uint32_t arg)
@  Return : 0 on SUCCESS; -1 on FAILURE.
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_send_command
.global hsmci_send_command
hsmci_send_command:
    PUSH    {R4-R5,LR}              @ Preserve necessary to call pause().
    LDR     R5,=(_HSMCI)            @ HSMCI register group base address.
    STR     R1,[R5,#_MCIARGRV]      @ Set Argument.
    STR     R0,[R5,#_MCICMDRV]      @ Write and start command.
    AND     R4,R0,#_MCIRSPTYPMSK    @ Isolate response type.
.hsc_wtrdy:
    LDR     R1,[R5,#_MCISRV]        @ Get status.
    ANDS    R0,R1,#_MCICMDRDY       @ Check command ready state.
    BNE     .hsc_ckerr              @ Command complete.
    BL      pause                   @ Allow other tasks while waiting.
    B       .hsc_wtrdy              @ Wait for command completion.
.hsc_ckerr:
    ANDS    R0,R1,#_RSPERR          @ Check for response errors.
    BNE     .hsc_err                @ ERROR.
    CMP     R4,#_MCIRSPR1B          @ Check for busy response type.
    BNE     .hsc_ok                 @ Done; Return SUCCESS.
.hsc_busy:
    BL      pause                   @ Allow other tasks while waiting.
    LDR     R1,[R5,#_MCISRV]        @ Get status.
    ANDS    R0,R1,#_MCINOTBUSY      @ Check Busy condition.
    BEQ     .hsc_busy               @ Busy.
.hsc_ok:
    MOV     R0,#0                   @ Return SUCCESS.
    B       .hsc_rtn                @ Done.
.hsc_err:
    MVN     R0,#0                   @ Return ERROR.
.hsc_rtn:
    POP     {R4-R5,PC}              @ Restore registers and return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI wait for busy signal clear.
@  From C - void hsmci_wait_busy(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_wait_busy
.global hsmci_wait_busy
hsmci_wait_busy:
    PUSH    {R4,LR}                 @ Preserve necessary to call pause().
    LDR     R4,=(_HSMCI)            @ HSMCI register group base address.
.hwb_busy:
    BL      pause                   @ Allow other tasks while waiting.
    LDR     R0,[R4,#_MCISRV]        @ Get status.
    ANDS    R0,#_MCINOTBUSY         @ Check Busy condition.
    BEQ     .hwb_busy               @ Busy.
    POP     {R4,PC}                 @ Restore registers and return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI set 4-bit mode.
@  From C - void hsmci_set_4bit(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_set_4bitbus
.global hsmci_set_4bitbus
hsmci_set_4bitbus:
    LDR     R2,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R2,#_MCISDCRV]      @ SD/SDIO configuration.
    LDR     R1,=(~_MCISDCBUSMSK)    @ Bus width bit-mask.
    AND     R0,R1,R0                @ Isolate card bus width.
    ORR     R0,#_MCISDCBUS4         @ Set 4-bit bus mode.
    STR     R0,[R2,#_MCISDCRV]      @ Update SDCard SDIO.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI enable RD/WR proof.
@  From C - void hsmci_enable_rdwrproof(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_enable_rdwrproof
.global hsmci_enable_rdwrproof
hsmci_enable_rdwrproof:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCIMRV]        @ Get current mode.
    ORR     R0,#_RDWRPROOF          @ Enable RD/WR Proof.
    STR     R0,[R1,#_MCIMRV]        @ Update mode.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI disable RD/WR proof.
@  From C - void hsmci_disable_rdwrproof(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_disable_rdwrproof
.global hsmci_disable_rdwrproof
hsmci_disable_rdwrproof:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCIMRV]        @ Get current mode.
    AND     R0,#~_RDWRPROOF         @ Disable RD/WR Proof.
    STR     R0,[R1,#_MCIMRV]        @ Update mode.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI enable force byte.
@  From C - void hsmci_enable_forcebyte(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_enable_forcebyte
.global hsmci_enable_forcebyte
hsmci_enable_forcebyte:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCIMRV]        @ Get current mode.
    ORR     R0,#_MCIFBYTE           @ Enable Force Byte.
    STR     R0,[R1,#_MCIMRV]        @ Update mode.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI disable force byte.
@  From C - void hsmci_disable_forcebyte(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_disable_forcebyte
.global hsmci_disable_forcebyte
hsmci_disable_forcebyte:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCIMRV]        @ Get current mode.
    AND     R0,#~_MCIFBYTE          @ Disable Force Byte.
    STR     R0,[R1,#_MCIMRV]        @ Update mode.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI set block.
@  From C - void hsmci_set_block(uint32_t)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_set_block
.global hsmci_set_block
hsmci_set_block:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    STR     R0,[R1,#_MCIBLKRV]      @ Set block transfer size.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI get block.
@  From C - uint32_t hsmci_get_block(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_get_block
.global hsmci_get_block
hsmci_get_block:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    LDR     R0,[R1,#_MCIBLKRV]      @ Return block transfer size.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI enable DMA.
@  From C - void hsmci_enable_dma(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_enable_dma
.global hsmci_enable_dma
hsmci_enable_dma:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    MOV     R0,#_MCIDMAEN           @ DMA enable.
    STR     R0,[R1,#_MCIDMAV]       @ Enable DMA.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI disable DMA.
@  From C - void hsmci_disable_dma(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_disable_dma
.global hsmci_disable_dma
hsmci_disable_dma:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    MOV     R0,#0                   @ DMA disable.
    STR     R0,[R1,#_MCIDMAV]       @ Disable DMA.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ HSMCI get FIFO base address.
@  From C - uint32_t hsmci_get_fifo(void)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_get_fifo
.global hsmci_get_fifo
hsmci_get_fifo:
    LDR     R0,=(_MCIFIFO0)         @ HSMCI FIFO base address (FIFO[0]).
    BX      LR                      @ Return.
.endfunc
.align
@-----------------------------------------------------------------------------
@ HSMCI set data timeout.
@  From C - void hsmci_set_data_timeout(uint32_t)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_set_data_timeout
.global hsmci_set_data_timeout
hsmci_set_data_timeout:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    STR     R0,[R1,#_MCIDTORV]      @ Set DTOR data timeout.
    BX      LR                      @ Return.
.endfunc
.align
@-----------------------------------------------------------------------------
@ HSMCI set completion signal timeout.
@  From C - void hsmci_set_completion_timeout(uint32_t)
@-----------------------------------------------------------------------------
.align
.thumb_func
.func   hsmci_set_completion_timeout
.global hsmci_set_completion_timeout
hsmci_set_completion_timeout:
    LDR     R1,=(_HSMCI)            @ HSMCI register group base address.
    STR     R0,[R1,#_MCICSTORV]     @ Set CSTOR completion signal timeout.
    BX      LR                      @ Return.
.endfunc
.align
@-----------------------------------------------------------------------------
.end
@------------------------------------------------------------------------------
@ end: hsmci.s
