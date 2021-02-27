//-----------------------------------------------------------------------------
// file: xdmac.h
//
// SmegARM ATSAME70 XDMAC interface driver example.
//
// Copyright (c) 2020 - Dysfunctional Farms A.K.A. www.smegware.com
//
//  All Smegware software is free; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This software is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//-----------------------------------------------------------------------------
//
// History...
//
//   $Source$
//   $Author$
// $Revision$
//
// $Log$
//-----------------------------------------------------------------------------

#include <stdint.h>

#define COMPILER_WORD_ALIGNED    __attribute__((__aligned__(4)))

// DMA channel hardware interface number.

#define XDMAC_CHANNEL_HWID_HSMCI      0
#define XDMAC_CHANNEL_HWID_SPI0_TX    1
#define XDMAC_CHANNEL_HWID_SPI0_RX    2
#define XDMAC_CHANNEL_HWID_SPI1_TX    3
#define XDMAC_CHANNEL_HWID_SPI1_RX    4
#define XDMAC_CHANNEL_HWID_QSPI_TX    5
#define XDMAC_CHANNEL_HWID_QSPI_RX    6
#define XDMAC_CHANNEL_HWID_USART0_TX  7
#define XDMAC_CHANNEL_HWID_USART0_RX  8
#define XDMAC_CHANNEL_HWID_USART1_TX  9
#define XDMAC_CHANNEL_HWID_USART1_RX  10
#define XDMAC_CHANNEL_HWID_USART2_TX  11
#define XDMAC_CHANNEL_HWID_USART2_RX  12
#define XDMAC_CHANNEL_HWID_PWM0       13
#define XDMAC_CHANNEL_HWID_TWIHS0_TX  14
#define XDMAC_CHANNEL_HWID_TWIHS0_RX  15
#define XDMAC_CHANNEL_HWID_TWIHS1_TX  16
#define XDMAC_CHANNEL_HWID_TWIHS1_RX  17
#define XDMAC_CHANNEL_HWID_TWIHS2_TX  18
#define XDMAC_CHANNEL_HWID_TWIHS2_RX  19
#define XDMAC_CHANNEL_HWID_UART0_TX   20
#define XDMAC_CHANNEL_HWID_UART0_RX   21
#define XDMAC_CHANNEL_HWID_UART1_TX   22
#define XDMAC_CHANNEL_HWID_UART1_RX   23
#define XDMAC_CHANNEL_HWID_UART2_TX   24
#define XDMAC_CHANNEL_HWID_UART2_RX   25
#define XDMAC_CHANNEL_HWID_UART3_TX   26
#define XDMAC_CHANNEL_HWID_UART3_RX   27
#define XDMAC_CHANNEL_HWID_UART4_TX   28
#define XDMAC_CHANNEL_HWID_UART4_RX   29
#define XDMAC_CHANNEL_HWID_DAC        30
#define XDMAC_CHANNEL_HWID_SSC_TX     32
#define XDMAC_CHANNEL_HWID_SSC_RX     33
#define XDMAC_CHANNEL_HWID_PIOA       34
#define XDMAC_CHANNEL_HWID_AFEC0      35
#define XDMAC_CHANNEL_HWID_AFEC1      36
#define XDMAC_CHANNEL_HWID_AES_TX     37
#define XDMAC_CHANNEL_HWID_AES_RX     38
#define XDMAC_CHANNEL_HWID_PWM1       39
#define XDMAC_CHANNEL_HWID_TC0        40
#define XDMAC_CHANNEL_HWID_TC1        41
#define XDMAC_CHANNEL_HWID_TC2        42
#define XDMAC_CHANNEL_HWID_TC3        43

// XDMAC Next Descriptor Control Register.
#define   XDMAC_CNDC_NDE              (0x1 << 0)
#define   XDMAC_CNDC_NDE_FETCH_DIS    (0x0 << 0)
#define   XDMAC_CNDC_NDE_FETCH_EN     (0x1 << 0)
#define   XDMAC_CNDC_NDSUP            (0x1 << 1)
#define   XDMAC_CNDC_NDSUP_UNCHANGED  (0x0 << 1)
#define   XDMAC_CNDC_NDSUP_UPDATED    (0x1 << 1)
#define   XDMAC_CNDC_NDDUP            (0x1 << 2)
#define   XDMAC_CNDC_NDDUP_UNCHANGED  (0x0 << 2)
#define   XDMAC_CNDC_NDDUP_UPDATED    (0x1 << 2)
#define   XDMAC_CNDC_NVIEW_Msk        (0x3 << 3)
#define   XDMAC_CNDC_NVIEW_NDV0       (0x0 << 3)
#define   XDMAC_CNDC_NVIEW_NDV1       (0x1 << 3)
#define   XDMAC_CNDC_NVIEW_NDV2       (0x2 << 3)
#define   XDMAC_CNDC_NVIEW_NDV3       (0x3 << 3)

// XDMAC Block Control Register.
#define XDMAC_CBC_BLENMSK         0X00000FFF  /* Block length mask.                   */
#define XDMAC_CBC_BLEN(x)         ((x) & XDMAC_CBC_BLENMSK)

// XDMAC Interrupt Registers.
#define XDMAC_CI_BI               (1 << 0)    /* End of Block Interrupt.              */
#define XDMAC_CI_LI               (1 << 1)    /* End of Linked List Interrupt.        */
#define XDMAC_CI_DI               (1 << 2)    /* End of Disable Interrupt.            */
#define XDMAC_CI_FI               (1 << 3)    /* End of Flush Interrupt.              */
#define XDMAC_CI_RBEI             (1 << 4)    /* Read Bus Error Interrupt.            */
#define XDMAC_CI_WBEI             (1 << 5)    /* Write Bus Error Interrupt.           */
#define XDMAC_CI_ROI              (1 << 6)    /* Request Overflow Error Interrupt.    */

// XDMAC Configuration Register.
#define XDMAC_CC_TYPE_MEM_TRAN    (0 << 0)    /* Transfer type Memory to Memory.      */
#define XDMAC_CC_TYPE_PER_TRAN    (1 << 0)    /* Transfer type Peripheral and Memory. */
#define XDMAC_CC_MBSIZE_SINGLE    (0 << 1)    /* Memory burst size set to one.        */
#define XDMAC_CC_MBSIZE_FOUR      (1 << 1)    /* Memory burst size set to four.       */
#define XDMAC_CC_MBSIZE_EIGHT     (2 << 1)    /* Memory burst size set to eight.      */
#define XDMAC_CC_MBSIZE_SIXTEEN   (3 << 1)    /* Memory burst size set to sixteen.    */
#define XDMAC_CC_DSYNC_PER2MEM    (0 << 4)    /* Peripheral to Memory transfer.       */
#define XDMAC_CC_DSYNC_MEM2PER    (1 << 4)    /* Memory to Peripheral transfer.       */
#define XDMAC_CC_SWREQ_HWR        (0 << 6)    /* Hardware request to peripheral.      */
#define XDMAC_CC_SWREQ_SWR        (1 << 6)    /* Software request to peripheral.      */
#define XDMAC_CC_MEMSET_NORMAL    (0 << 7)    /* Memset is not selected.              */
#define XDMAC_CC_MEMSET_HW        (1 << 7)    /* Set block to specified value.        */
#define XDMAC_CC_CSIZE_CHK_1      (0 << 8)    /* 1 data transfered.                   */
#define XDMAC_CC_CSIZE_CHK_2      (1 << 8)    /* 2 data transfered.                   */
#define XDMAC_CC_CSIZE_CHK_4      (2 << 8)    /* 4 data transfered.                   */
#define XDMAC_CC_CSIZE_CHK_8      (3 << 8)    /* 8 data transfered.                   */
#define XDMAC_CC_CSIZE_CHK_16     (4 << 8)    /* 16 data transfered.                  */
#define XDMAC_CC_DWIDTH_BYTE      (0 << 11)   /* Data size is set to 8-bits.          */
#define XDMAC_CC_DWIDTH_HALF      (1 << 11)   /* Data size is set to 16-bits.         */
#define XDMAC_CC_DWIDTH_WORD      (2 << 11)   /* Data size is set to 32-bits.         */
#define XDMAC_CC_SIF_AHB_IF0      (0 << 13)   /* Source interface on system bus 0.    */
#define XDMAC_CC_SIF_AHB_IF1      (1 << 13)   /* Source interface on system bus 1.    */
#define XDMAC_CC_DIF_AHB_IF0      (0 << 14)   /* Dest interface on system bus 0.      */
#define XDMAC_CC_DIF_AHB_IF1      (1 << 14)   /* Dest interface on system bus 1.      */
#define XDMAC_CC_SAM_FIXED_AM     (0 << 16)   /* Address remains unchanged.           */
#define XDMAC_CC_SAM_INCR_AM      (1 << 16)   /* Addressing mode is incremented.      */
#define XDMAC_CC_SAM_UBS_AM       (2 << 16)   /* Microblock stride added at boundary. */
#define XDMAC_CC_SAM_UBS_DM_AM    (3 << 16)   /* Micro Data stride added at boundary. */
#define XDMAC_CC_DAM_FIXED_AM     (0 << 18)   /* Address remains unchanged.           */
#define XDMAC_CC_DAM_INCR_AM      (1 << 18)   /* Addressing mode is incremented.      */
#define XDMAC_CC_DAM_UBS_AM       (2 << 18)   /* Microblock stride added at boundary. */
#define XDMAC_CC_DAM_UBS_DM_AM    (3 << 18)   /* Micro Data stride added at boundary. */

#define XDMAC_CC_PERID_MSK        (7 << 24)   /*  */
#define XDMAC_CC_PERID(x)         (((x) << 24) & XDMAC_CC_PERID_MSK)

// Linked List descriptor view 1 style.
typedef struct _lld_view1 {
	uint32_t mbr_nda;	// Addr of next descriptor.
	uint32_t mbr_ubc;	// Control settings of MBR_UBC.
	uint32_t mbr_sa;	// Next source addr.
	uint32_t mbr_da;	// Next destination addr.
} lld_view1;

extern void xdmac_init(void);
extern void xdmac_enable_pmc(void);
extern void xdmac_enable_channel(uint32_t);
extern void xdmac_disable_channel(uint32_t);
extern uint32_t xdmac_get_global_status(void);
extern void xdmac_disable_global_interrupt(uint32_t);
extern uint32_t xdmac_get_global_interrupt_status(void);
extern void xdmac_set_configuration(uint32_t, uint32_t);
extern void xdmac_set_microblock_control(uint32_t, uint32_t);
extern void xdmac_set_block_control(uint32_t, uint32_t);
extern void xdmac_set_data_stride_msp(uint32_t, uint32_t);
extern void xdmac_set_source_micro_stride(uint32_t, uint32_t);
extern void xdmac_set_dest_micro_stride(uint32_t, uint32_t);
extern void xdmac_set_source_address(uint32_t, uint32_t);
extern void xdmac_set_dest_address(uint32_t, uint32_t);
extern void xdmac_set_next_address(uint32_t, uint32_t);
extern void xdmac_set_next_control(uint32_t, uint32_t);
extern uint32_t xdmac_get_interrupt_status(uint32_t);
extern void xdmac_enable_channel_interrupt(uint32_t, uint32_t);
extern void xdmac_disable_channel_interrupt(uint32_t, uint32_t);

extern void xdmac_prepare_channel(uint32_t channel);

//------------------------------------------------------------------------------
// end: xdmac.h
