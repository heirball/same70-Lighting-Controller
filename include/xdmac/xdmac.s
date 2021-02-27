@-----------------------------------------------------------------------------
@ file: xdmac.s
@
@ SmegARM ATSAME70 XDMAC interface driver example.
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
@ Power Management Controller XDMAC setup.
.equ _PMC_XDMAC,      (_PID_XDMAC | _PMCPCRCMD | _PMCPCREN)
@ Power Management Controller XDMAC setup.
.equ _NVIC_XDMAC,     (1 << _PID_XDMAC)
@-----------------------------------------------------------------------------
.equ  _DMACHMAX,      24            @ Maximum number of DMA Channels.
@-----------------------------------------------------------------------------
.section .bss
@-----------------------------------------------------------------------------
.section .text.smegconst
_DMACHV:  @ Array of channel register offset vectors.
  .hword  (0 * 40),(1 * 40),(2 * 40),(3 * 40),(4 * 40),(5 * 40),(6 * 40),(7 * 40)
  .hword  (8 * 40),(9 * 40),(10 * 40),(11 * 40),(12 * 40),(13 * 40),(14 * 40),(15 * 40)
  .hword  (16 * 40),(17 * 40),(18 * 40),(19 * 40),(20 * 40),(21 * 40),(22 * 40),(23 * 40)
@-----------------------------------------------------------------------------
.section .text.smeglib
@ Enable Thumb-2 instructions.
.syntax unified
@-----------------------------------------------------------------------------
@ XDMAC initialize.
@  From C - void xdmac_init(void)
.align
.thumb_func
.func   xdmac_init
.global xdmac_init
xdmac_init:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC enable PMC clock.
@  From C - void xdmac_enable_pmc(void)
.align
.thumb_func
.func   xdmac_enable_pmc
.global xdmac_enable_pmc
xdmac_enable_pmc:
    LDR     R1,=(_PMCPCR)           @ PMC Peripheral Control Register.
    LDR     R0,=(_PMC_XDMAC)        @ XDMAC clock config.
    STR     R0,[R1]                 @ Enable XDMAC peripheral clock.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC enable channel.
@  From C - void xdmac_enable_channel(uint32_t)
.align
.thumb_func
.func   xdmac_enable_channel
.global xdmac_enable_channel
xdmac_enable_channel:
    LDR     R1,=(_XDMAC)            @ XDMAC register group base address.
    STR     R0,[R1,#_XDMACGEV]      @ Enable DMA channel(s).
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC disable channel.
@  From C - void xdmac_disable_channel(uint32_t)
.align
.thumb_func
.func   xdmac_disable_channel
.global xdmac_disable_channel
xdmac_disable_channel:
    LDR     R1,=(_XDMAC)            @ XDMAC register group base address.
    STR     R0,[R1,#_XDMACGDV]      @ Disable DMA channel(s).
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC get global status
@  From C - uint32_t xdmac_get_global_status(void)
.align
.thumb_func
.func   xdmac_get_global_status
.global xdmac_get_global_status
xdmac_get_global_status:
    LDR     R1,=(_XDMAC)            @ XDMAC register group base address.
    LDR     R0,[R1,#_XDMACGSV]      @ Return global channel status.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC disable global interrupt.
@  From C - void xdmac_disable_global_interrupt(uint32_t)
.align
.thumb_func
.func   xdmac_disable_global_interrupt
.global xdmac_disable_global_interrupt
xdmac_disable_global_interrupt:
    LDR     R1,=(_XDMAC)            @ XDMAC register group base address.
    STR     R0,[R1,#_XDMACGIDV]     @ Disable DMA global interrupt(s).
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC get global interrupt status.
@  From C - uint32_t xdmac_get_global_interrupt_status(void)
.align
.thumb_func
.func   xdmac_get_global_interrupt_status
.global xdmac_get_global_interrupt_status
xdmac_get_global_interrupt_status:
    LDR     R1,=(_XDMAC)            @ XDMAC register group base address.
    LDR     R0,[R1,#_XDMACGISV]     @ Return DMA global interrupt status.
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set channel configuration.
@  From C - void xdmac_set_configuration(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_configuration
.global xdmac_set_configuration
xdmac_set_configuration:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scc_exit               @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCC)          @ XDMAC Channel Configuration register.
    STR     R1,[R2,R0]              @ Set channel configuration.
.scc_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set channel microblock control.
@  From C - void xdmac_set_microblock_control(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_microblock_control
.global xdmac_set_microblock_control
xdmac_set_microblock_control:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scubc_exit             @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCUBC)        @ XDMAC Microblock Control register.
    STR     R1,[R2,R0]              @ Set channel microblock.
.scubc_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set channel block control.
@  From C - void xdmac_set_block_control(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_block_control
.global xdmac_set_block_control
xdmac_set_block_control:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scbc_exit              @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCBC)         @ XDMAC Block Control register.
    STR     R1,[R2,R0]              @ Set channel block control.
.scbc_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set data stride memory set pattern.
@  From C - void xdmac_set_data_stride_msp(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_data_stride_msp
.global xdmac_set_data_stride_msp
xdmac_set_data_stride_msp:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scdsm_exit             @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCDSMSP)      @ XDMAC Data Stride Memory Set Pattern register.
    STR     R1,[R2,R0]              @ Set data stride memory set pattern.
.scdsm_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set source microblock stride.
@  From C - void xdmac_set_source_micro_stride(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_source_micro_stride
.global xdmac_set_source_micro_stride
xdmac_set_source_micro_stride:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scsus_exit             @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCSUS)        @ XDMAC Source Microblock Stride register.
    STR     R1,[R2,R0]              @ Set source microblock stride.
.scsus_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set destination microblock stride.
@  From C - void xdmac_set_dest_micro_stride(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_dest_micro_stride
.global xdmac_set_dest_micro_stride
xdmac_set_dest_micro_stride:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scdus_exit             @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCDUS)        @ XDMAC Destination Microblock Stride register.
    STR     R1,[R2,R0]              @ Set destination microblock stride.
.scdus_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set DMA source address.
@  From C - void xdmac_set_source_address(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_source_address
.global xdmac_set_source_address
xdmac_set_source_address:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scsa_exit              @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCSA)         @ XDMAC Source Address register.
    STR     R1,[R2,R0]              @ Set source address.
.scsa_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set DMA destination address.
@  From C - void xdmac_set_dest_address(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_dest_address
.global xdmac_set_dest_address
xdmac_set_dest_address:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scda_exit              @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCDA)         @ XDMAC Destination Address register.
    STR     R1,[R2,R0]              @ Set destination address.
.scda_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set DMA next descriptor address.
@  From C - void xdmac_set_next_address(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_next_address
.global xdmac_set_next_address
xdmac_set_next_address:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scnda_exit             @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCNDA)        @ XDMAC Next Descriptor Address register.
    STR     R1,[R2,R0]              @ Set next descriptor address.
.scnda_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC set DMA next descriptor control.
@  From C - void xdmac_set_next_control(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_set_next_control
.global xdmac_set_next_control
xdmac_set_next_control:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scndc_exit             @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCNDC)        @ XDMAC Next Descriptor Control register.
    STR     R1,[R2,R0]              @ Set next descriptor control.
.scndc_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC get interrupt status.
@  From C - uint32_t xdmac_get_interrupt_status(uint32_t channel)
.align
.thumb_func
.func   xdmac_get_interrupt_status
.global xdmac_get_interrupt_status
xdmac_get_interrupt_status:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scis_exit              @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCIS)         @ XDMAC Interrupt Status register.
    LDR     R0,[R2,R0]              @ Return interrupt status.
.scis_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC enable channel interrupt.
@  From C - void xdmac_enable_channel_interrupt(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_enable_channel_interrupt
.global xdmac_enable_channel_interrupt
xdmac_enable_channel_interrupt:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scie_exit              @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCIE)         @ XDMAC Channel Interrupt Enable register.
    STR     R0,[R2,R0]              @ Enable channel interrupts.
.scie_exit:
    BX      LR                      @ Return.
.endfunc
@-----------------------------------------------------------------------------
@ XDMAC disable channel interrupt.
@  From C - void xdmac_disable_channel_interrupt(uint32_t channel, uint32_t value)
.align
.thumb_func
.func   xdmac_disable_channel_interrupt
.global xdmac_disable_channel_interrupt
xdmac_disable_channel_interrupt:
    CMP     R0,#_DMACHMAX           @ Bounds check channel.
    BGE     .scid_exit              @ Channel out of range.
    LDR     R2,=(_DMACHV)           @ Channel offset index table.
    LDRH    R0,[R2,R0,LSL #1]       @ Convert channel number to register offset.
    LDR     R2,=(_XDMACCID)         @ XDMAC Channel Interrupt Disable register.
    STR     R0,[R2,R0]              @ Disable channel interrupts.
.scid_exit:
    BX      LR                      @ Return.
.endfunc
.align
@-----------------------------------------------------------------------------
.end
@------------------------------------------------------------------------------
@ end: xdmac.s
