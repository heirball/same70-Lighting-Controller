@-----------------------------------------------------------------------------
@ file: atsame70.i
@
@ SmegARM SAME70 Cortex-M7 Hardware definitions.
@
@ Copyright (c) 2020 - Dysfunctional Farms A.K.A. www.smegware.com
@
@  All Smegware software is free you can redistribute it and/or modify
@  it under the terms of the GNU General Public License as published by
@  the Free Software Foundation either version 2 of the License, or
@  (at your option) any later version.
@
@  This software is distributed in the hope that it will be useful,
@  but WITHOUT ANY WARRANTY without even the implied warranty of
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
@ HSMCI Register offsets from group base address.
.equ  _MCICRV,      0X0000      @ Control Register offset.
.equ  _MCIMRV,      0X0004      @ Mode Register offset.
.equ  _MCIDTORV,    0X0008      @ Data Timeout Register offset.
.equ  _MCISDCRV,    0X000C      @ SD/SDIO Card Register offset.
.equ  _MCIARGRV,    0X0010      @ Argument Register offset.
.equ  _MCICMDRV,    0X0014      @ Command Register offset.
.equ  _MCIBLKRV,    0X0018      @ Block Register offset.
.equ  _MCICSTORV,   0X001C      @ Completion Signal Timeout Register offset.
.equ  _MCIRSPRV,    0X0020      @ Response Register offset.
.equ  _MCIRSPR1V,   0X0024      @ Response Register offset.
.equ  _MCIRSPR2V,   0X0028      @ Response Register offset.
.equ  _MCIRSPR3V,   0X002C      @ Response Register offset.
.equ  _MCIRDRV,     0X0030      @ Receive Data Register offset.
.equ  _MCITDRV,     0X0034      @ Transmit Data Register offset.
.equ  _MCISRV,      0X0040      @ Status Register offset.
.equ  _MCIIERV,     0X0044      @ Interrupt Enable Register offset.
.equ  _MCIIDRV,     0X0048      @ Interrupt Disable Register offset.
.equ  _MCIIMRV,     0X004C      @ Interrupt Mask Register offset.
.equ  _MCIDMAV,     0X0050      @ DMA Configuration Register offset.
.equ  _MCICFGV,     0X0054      @ Configuration Register offset.
.equ  _MCIWPMRV,    0X00E4      @ Write Protection Mode Register offset.
.equ  _MCIWPSRV,    0X00E8      @ Write Protection Status Register offset.
.equ  _MCIFIFO0V,   0X0200      @ FIFO Memory Aperature0 offset.
.equ  _MCIFIFO255V, 0X05FC      @ FIFO Memory Aperature255 offset.
@-----------------------------------------------------------------------------
@ HSMCI Register definitions.
.equ  _HSMCI,       0X40000000              @ HSMCI register group base address.
.equ  _MCICR,       (_HSMCI + _MCICRV)      @ Control Register.
.equ  _MCIMR,       (_HSMCI + _MCIMRV)      @ Mode Register.
.equ  _MCIDTOR,     (_HSMCI + _MCIDTORV)    @ Data Timeout Register.
.equ  _MCISDCR,     (_HSMCI + _MCISDCRV)    @ SD/SDIO Card Register.
.equ  _MCIARGR,     (_HSMCI + _MCIARGRV)    @ Argument Register.
.equ  _MCICMDR,     (_HSMCI + _MCICMDRV)    @ Command Register.
.equ  _MCIBLKR,     (_HSMCI + _MCIBLKRV)    @ Block Register.
.equ  _MCICSTOR,    (_HSMCI + _MCICSTORV)   @ Completion Signal Timeout Register.
.equ  _MCIRSPR,     (_HSMCI + _MCIRSPRV)    @ Response Register.
.equ  _MCIRSPR1,    (_HSMCI + _MCIRSPR1V)   @ Response Register.
.equ  _MCIRSPR2,    (_HSMCI + _MCIRSPR2V)   @ Response Register.
.equ  _MCIRSPR3,    (_HSMCI + _MCIRSPR3V)   @ Response Register.
.equ  _MCIRDR,      (_HSMCI + _MCIRDRV)     @ Receive Data Register.
.equ  _MCITDR,      (_HSMCI + _MCITDRV)     @ Transmit Data Register.
.equ  _MCISR,       (_HSMCI + _MCISRV)      @ Status Register.
.equ  _MCIIER,      (_HSMCI + _MCIIERV)     @ Interrupt Enable Register.
.equ  _MCIIDR,      (_HSMCI + _MCIIDRV)     @ Interrupt Disable Register.
.equ  _MCIIMR,      (_HSMCI + _MCIIMRV)     @ Interrupt Mask Register.
.equ  _MCIDMA,      (_HSMCI + _MCIDMAV)     @ DMA Configuration Register.
.equ  _MCICFG,      (_HSMCI + _MCICFGV)     @ Configuration Register.
.equ  _MCIWPMR,     (_HSMCI + _MCIWPMRV)    @ Write Protection Mode Register.
.equ  _MCIWPSR,     (_HSMCI + _MCIWPSRV)    @ Write Protection Status Register.
.equ  _MCIFIFO0,    (_HSMCI + _MCIFIFO0V)   @ FIFO Memory Aperature0.
.equ  _MCIFIFO255,  (_HSMCI + _MCIFIFO255V) @ FIFO Memory Aperature255.
@-----------------------------------------------------------------------------
@ High Speed Media Card Interface bit-field definitions.
@ HSMCI_CR Control Register.
.equ  _MCIEN,         (1 << 0)      @ Multi-Media Interface Enable.
.equ  _MCIDIS,        (1 << 1)      @ Multi-Media Interface Disable.
.equ  _MCIPWSEN,      (1 << 2)      @ Power Save Mode Enable.
.equ  _MCIPWDIS,      (1 << 3)      @ Power Save Mode Disable.
.equ  _MCISWRST,      (1 << 7)      @ HSMCI Software Reset.
@ HSMCI_MR Mode Register.
.equ  _MCICLKDIVMSK,  (0XFF << 0)   @ Clock Divider bit-mask.
.equ  _MCIPWSDIVMSK,  (0X07 << 8)   @ Power Saving Divider bit-mask.
.equ  _MCIRDPROOF,    (1 << 11)     @ Read Proof Enable.
.equ  _MCIWRPROOF,    (1 << 12)     @ Write Proof Enable.
.equ  _MCIFBYTE,      (1 << 13)     @ Force Byte Transfer.
.equ  _MCIPADV,       (1 << 14)     @ Padding Value.
.equ  _MCICLKODD,     (1 << 16)     @ Clock Divider is odd.
@ HSMCI_DTOR Data Timeout Register.
.equ  _MCIDTOCYCMSK,  (0X0F << 0)   @ Data Timeout Cycle Number bit-mask.
.equ  _MCIDTOMULMSK,  (0XF0 << 4)   @ Data Timeout Multiplier bit-mask.
.equ  _MCIDTM1,       (0 << 4)      @ DTOCYC 0.
.equ  _MCIDTM16,      (1 << 4)      @ DTOCYC x 16.
.equ  _MCIDTM128,     (2 << 4)      @ DTOCYC x 128.
.equ  _MCIDTM256,     (3 << 4)      @ DTOCYC x 256.
.equ  _MCIDTM1024,    (4 << 4)      @ DTOCYC x 1024.
.equ  _MCIDTM4096,    (5 << 4)      @ DTOCYC x 4096.
.equ  _MCIDTM65536,   (6 << 4)      @ DTOCYC x 65536.
.equ  _MCIDTM1048576, (7 << 4)      @ DTOCYC x 1048576.
@ HSMCI_SCDR SDCard/SDIO Register.
.equ  _MCISDCSELMSK,  (3 << 0)      @ Slot bit-mask.
.equ  _MCISDCSELA,    (0 << 0)      @ Slot A is selected.
.equ  _MCISDCSELB,    (1 << 0)      @ Reserved.
.equ  _MCISDCSELC,    (2 << 0)      @ Reserved.
.equ  _MCISDCSELD,    (3 << 0)      @ Reserved.
.equ  _MCISDCBUSMSK,  (3 << 6)      @ Bus width bit-mask.
.equ  _MCISDCBUS1,    (0 << 6)      @ 1 bit.
.equ  _MCISDCBUS4,    (2 << 6)      @ 4 bits.
.equ  _MCISDCBUS8,    (3 << 6)      @ 8 bits.
@ HSMCI_CMDR Command Register.
.equ  _MCICMDNBMSK,   (0X3F << 0)   @ Command Number bit-mask.
.equ  _MCIRSPTYPMSK,  (0X03 << 6)   @ Response Type bit-mask.
.equ  _MCIRSPNONE,    (0 << 6)      @ Response Type - No response.
.equ  _MCIRSP48,      (1 << 6)      @ Response Type - 48-bit response.
.equ  _MCIRSP136,     (2 << 6)      @ Response Type - 136-bit response.
.equ  _MCIRSPR1B,     (3 << 6)      @ Response Type - R1B response type.
.equ  _MCISPCMDMSK,   (0X07 << 8)   @ Special Command bit-mask.
.equ  _MCISPCSTD,     (0 << 8)      @ Not a special CMD.
.equ  _MCISPCINIT,    (1 << 8)      @ Initialize CMD.
.equ  _MCISPCSYNC,    (2 << 8)      @ Schronized CMD.
.equ  _MCISPCCEATA,   (3 << 8)      @ CE-ATA Completion Signal disable Command.
.equ  _MCISPCITCMD,   (4 << 8)      @ Interrupt Command.
.equ  _MCISPCITRESP,  (5 << 8)      @ Interrupt response.
.equ  _MCISPCBOR,     (6 << 8)      @ Boot Operation Request.
.equ  _MCISPCEBO,     (7 << 8)      @ End Boot Operation.
.equ  _MCIOPDCMD,     (1 << 11)     @ Open Drain Command.
.equ  _MCIMAXLAT,     (1 << 12)     @ Max Latency for Command to Response.
.equ  _MCITRCMDMSK,   (0X03 << 16)  @ Transfer Command bit-mask.
.equ  _MCITCNODAT,    (0 << 16)     @ No-Data Command.
.equ  _MCITCSTRTDAT,  (1 << 16)     @ Start-Data Command.
.equ  _MCITCSTOPDAT,  (2 << 16)     @ Stop-Data Command.
.equ  _MCITRDIR,      (1 << 18)     @ Transfer Direction.
.equ  _MCITRTYPMSK,   (0X07 << 19)  @ Transfer Type bit-mask.
.equ  _MCITTSINGLE,   (0 << 19)     @ MMC/SD Card Single Block.
.equ  _MCITTMULTI,    (1 << 19)     @ MMC/SD Card Multiple Block.
.equ  _MCITTSTREAM,   (2 << 19)     @ MMC Stream.
.equ  _MCITTBYTE,     (4 << 19)     @ SDIO Byte.
.equ  _MCITTBLOCK,    (5 << 19)     @ SDIO Block.
.equ  _MCIIOSPCMDMSK, (0X03 << 24)  @ SDIO Special Command bit-mask.
.equ  _MCISCSTD,      (0 << 24)     @ Not an SDIO Special Command.
.equ  _MCISCSUSPEND,  (1 << 24)     @ SDIO Suspend Command.
.equ  _MCISCRESUME,   (2 << 24)     @ SDIO Resume Command.
.equ  _MCIATACS,      (1 << 26)     @ ATA with Command Completion Signal.
.equ  _MCIBOOTACK,    (1 << 27)     @ Boot Operation Acknowledge.
@ HSMCI_SR Status Register.
.equ  _MCICMDRDY,     (1 << 0)      @ Command Ready.
.equ  _MCIRXRDY,      (1 << 1)      @ Receiver Ready.
.equ  _MCITXRDY,      (1 << 2)      @ Transmit Ready.
.equ  _MCIBLKE,       (1 << 3)      @ Data Block Ended.
.equ  _MCIDTIP,       (1 << 4)      @ Data Transfer In Progress.
.equ  _MCINOTBUSY,    (1 << 5)      @ HSMCI Not Busy.
.equ  _MCISDIOIRQA,   (1 << 8)      @ SDIO Interrupt for Slot A.
.equ  _MCISDIOWAIT,   (1 << 12)     @ SDIO Read Wait Operation.
.equ  _MCICSCRV,      (1 << 13)     @ Completion Signal Completed.
.equ  _MCIRINDE,      (1 << 16)     @ Response Index Error.
.equ  _MCIRDIRE,      (1 << 17)     @ Response Direction Error.
.equ  _MCIRCRCE,      (1 << 18)     @ Response CRC Error.
.equ  _MCIRENDE,      (1 << 19)     @ Response End Bit Error.
.equ  _MCIRTOE,       (1 << 20)     @ Response Time-Out Error.
.equ  _MCIDCRCE,      (1 << 21)     @ Data CRC Error.
.equ  _MCIDTOE,       (1 << 22)     @ Data Time-Out Error.
.equ  _MCICSTOE,      (1 << 23)     @ Completion Signal Time-Out Error.
.equ  _MCIBLKOVRE,    (1 << 24)     @ DMA Block Overrun Error.
.equ  _MCIFIFOEMPTY,  (1 << 26)     @ FIFO Empty.
.equ  _MCIXFRDONE,    (1 << 27)     @ Transfer Done.
.equ  _MCIACKRCV,     (1 << 28)     @ Boot Operation Acknowledge Received.
.equ  _MCIACKRCVE,    (1 << 29)     @ Boot Operation Acknowledge Error.
.equ  _MCIOVRE,       (1 << 30)     @ Overrun Error.
.equ  _MCIUNRE,       (1 << 31)     @ Underrun Error.
@ HSMCI_DMA DMA Configuration Register.
.equ  _MCIDMACSMSK,   (0X07 << 4)   @ DMA Channel Read/Write Chunk Size bit-msk.
.equ  _MCICHKSIZE1,   (0 << 4)      @ 1 data available.
.equ  _MCICHLZISE2,   (1 << 4)      @ 2 data available.
.equ  _MCICHLZISE4,   (2 << 4)      @ 4 data available.
.equ  _MCICHLZISE8,   (3 << 4)      @ 8 data available.
.equ  _MCICHLZISE16,  (4 << 4)      @ 16 data available.
.equ  _MCIDMAEN,      (1 << 8)      @ DMA Hardware Handshake Enable.
@ HSMCI_CFG Configuration Register.
.equ  _MCIFIFOMODE,   (1 << 0)      @ Internal FIFO Control Mode.
.equ  _MCIFERRCTRL,   (1 << 4)      @ Flow Error flag reset control mode.
.equ  _MCIHSMODE,     (1 << 8)      @ High Speed Mode.
.equ  _MCILSYNC,      (1 << 12)     @ Synchronization on the last block.
@ HSMCI_WMPR Write Protection Mode Register.
.equ  _MCIWPKEY,      0X4D434900    @ Write Protect Key (PASSWD).
.equ  _MCIWPEN,       (1 << 0)      @ Write Protect Key.
@-----------------------------------------------------------------------------
@ SPI0 Register offsets from group base address.
.equ  _SPICRV,      0X0000      @ Control Register.
.equ  _SPIMRV,      0X0004      @ Mode Register.
.equ  _SPIRDRV,     0X0008      @ Receive Data Register.
.equ  _SPITDRV,     0X000C      @ Transmit Data Register.
.equ  _SPISRV,      0X0010      @ Status Register.
.equ  _SPIIERV,     0X0014      @ Interrupt Enable Register.
.equ  _SPIIDRV,     0X0018      @ Interrupt Disable Register.
.equ  _SPIIMRV,     0X001C      @ Interrupt Mask Register.
.equ  _SPICSR0V,    0X0030      @ Chip Select Register 0
.equ  _SPICSR1V,    0X0034      @ Chip Select Register 1.
.equ  _SPICSR2V,    0X0038      @ Chip Select Register 2.
.equ  _SPICSR3V,    0X003C      @ Chip Select Register 3.
.equ  _SPIWPMRV,    0X00E4      @ Write Protection Control Register.
.equ  _SPIWPSRV,    0X00E8      @ Write Protection Status Register.
.equ  _PERIPHTCRV,  0X0120      @ Peripheral DMA Transfer Control Register.
@-----------------------------------------------------------------------------
@ SPI0 Register definitions.
.equ  _SPI0,      0X40008000              @ SPI0 register group base address.
.equ  _SPI0CR,    (_SPI0 + _SPICRV)       @ SPI0 Control Register.
.equ  _SPI0MR,    (_SPI0 + _SPIMRV)       @ SPI0 Mode Register.
.equ  _SPI0RDR,   (_SPI0 + _SPIRDRV)      @ SPI0 Receive Data Register.
.equ  _SPI0TDR,   (_SPI0 + _SPITDRV)      @ SPI0 Transmit Data Register.
.equ  _SPI0SR,    (_SPI0 + _SPISRV)       @ SPI0 Status Register.
.equ  _SPI0IER,   (_SPI0 + _SPIIERV)      @ SPI0 Interrupt Enable Register.
.equ  _SPI0IDR,   (_SPI0 + _SPIIDRV)      @ SPI0 Interrupt Disable Register.
.equ  _SPI0IMR,   (_SPI0 + _SPIIMRV)      @ SPI0 Interrupt Mask Register.
.equ  _SPI0CSR0,  (_SPI0 + _SPICSR0V)     @ SPI0 Chip Select Register 0
.equ  _SPI0CSR1,  (_SPI0 + _SPICSR1V)     @ SPI0 Chip Select Register 1.
.equ  _SPI0CSR2,  (_SPI0 + _SPICSR2V)     @ SPI0 Chip Select Register 2.
.equ  _SPI0CSR3,  (_SPI0 + _SPICSR3V)     @ SPI0 Chip Select Register 3.
.equ  _SPI0WPMR,  (_SPI0 + _SPIWPMRV)     @ SPI0 Write Protection Control Register.
.equ  _SPI0WPSR,  (_SPI0 + _SPIWPSRV)     @ SPI0 Write Protection Status Register.
.equ  _PERIPHTCR, (_SPI0 + _PERIPHTCRV)   @ SPI0 Peripheral DMA Transfer Control Register.
@ SPI1 Register definitions.
.equ  _SPI1,      0X40058000              @ SPI1 register group base address.
.equ  _SPI1CR,    (_SPI1 + _SPICRV)       @ SPI1 Control Register.
.equ  _SPI1MR,    (_SPI1 + _SPIMRV)       @ SPI1 Mode Register.
.equ  _SPI1RDR,   (_SPI1 + _SPIRDRV)      @ SPI1 Receive Data Register.
.equ  _SPI1TDR,   (_SPI1 + _SPITDRV)      @ SPI1 Transmit Data Register.
.equ  _SPI1SR,    (_SPI1 + _SPISRV)       @ SPI1 Status Register.
.equ  _SPI1IER,   (_SPI1 + _SPIIERV)      @ SPI1 Interrupt Enable Register.
.equ  _SPI1IDR,   (_SPI1 + _SPIIDRV)      @ SPI1 Interrupt Disable Register.
.equ  _SPI1IMR,   (_SPI1 + _SPIIMRV)      @ SPI1 Interrupt Mask Register.
.equ  _SPI1CSR0,  (_SPI1 + _SPICSR0V)     @ SPI1 Chip Select Register 0
.equ  _SPI1CSR1,  (_SPI1 + _SPICSR1V)     @ SPI1 Chip Select Register 1.
.equ  _SPI1CSR2,  (_SPI1 + _SPICSR2V)     @ SPI1 Chip Select Register 2.
.equ  _SPI1CSR3,  (_SPI1 + _SPICSR3V)     @ SPI1 Chip Select Register 3.
.equ  _SPI1WPMR,  (_SPI1 + _SPIWPMRV)     @ SPI1 Write Protection Control Register.
.equ  _SPI1WPSR,  (_SPI1 + _SPIWPSRV)     @ SPI1 Write Protection Status Register.
@-----------------------------------------------------------------------------
@ SPI Control Register bit-field definitions.
.equ  _FIFODIS,   (1 << 31)     @ SPI FIFO Disable bit-position.
.equ  _FIFOEN,    (1 << 30)     @ SPI FIFO Enable bit-position.
.equ  _LASTXFER,  (1 << 24)     @ Last Transfer bit-position.
.equ  _RXFCLR,    (1 << 17)     @ SPI Receife FIFO Clear bit-position.
.equ  _TXFCLR,    (1 << 16)     @ SPI Transmit FIFO Clear bit-position.
.equ  _REQCLR,    (1 << 12)     @ Request to Clear rhe Comparison Trigger bit-position.
.equ  _SWRST,     (1 << 7)      @ SPI Software Reset bit-position.
.equ  _SPDIDIS,   (1 << 1)      @ SPI Disable bit-position.
.equ  _SPIEN,     (1 << 0)      @ SPI Enable bit-position.
@ SPI Mode Register bit-field definitions.
.equ  _DLYBCSMSK, (0XFF << 24)    @ Delay Between Chip Selects bit-mask.
.equ  _PCS3,      (0B0111 << 16)  @ Peripheral Chip Select 3 bit-posision.
.equ  _PCS2,      (0B1011 << 16)  @ Peripheral Chip Select 2 bit-position.
.equ  _PCS1,      (0B1101 << 16)  @ Peripheral Chip Select 1 bit-position.
.equ  _PCS0,      (0B1110 << 16)  @ Peripheral Chip Select 0 bit-position.
.equ  _LLB,       (1 << 7)      @ Local Loop-Back Enable bit-position.
.equ  _WDRBT,     (1 << 5)      @ Wait Data Read Before Transfer bit-position.
.equ  _MODFDIS,   (1 << 4)      @ Mode Fault Detection bit-position.
.equ  _PCSDEC,    (1 << 2)      @ Chip Select Decode bit position.
.equ  _PS,        (1 << 1)      @ Variable/Fixed Peripheral Select bit-position.
.equ  _MSTR,      (1 << 0)      @ Master Mode Enable bit-position.
@ SPI Status and Interrupt Registers bit-field definitions.
.equ  _SPIENS,    (1 << 16)     @ SPI Enabled bit-position.
.equ  _UNDES,     (1 << 10)     @ Underrun Error bit-position.
.equ  _TXEMPTY,   (1 << 9)      @ Transmission Register Empty bit-position.
.equ  _NSSR,      (1 << 8)      @ NSS Rising bit-position.
.equ  _OVRES,     (1 << 3)      @ Overrun Error bit-position.
.equ  _MODF,      (1 << 2)      @ Mode Fault Error bit-position.
.equ  _TDRE,      (1 << 1)      @ Transmit Data Regiter Empty bit-position.
.equ  _RDRF,      (1 << 0)      @ Receiver Data Register Full bit-position.
@ SPI Chip Select Registers bit-field definitions.
.equ  _BITS8,     (0 << 4)      @ 8 Bits/Transfer bit-mask.
.equ  _BITS9,     (1 << 4)      @ 9 Bits/Transfer bit-mask.
.equ  _BITS10,    (2 << 4)      @ 10 Bits/Transfer bit-mask.
.equ  _BITS11,    (3 << 4)      @ 11 Bit/Transfeer bit-mask.
.equ  _BITS12,    (4 << 4)      @ 12 Bits/Transfer bit-mask
.equ  _BITS13,    (5 << 4)      @ 13 Bits/Transfer bit-mask.
.equ  _BITS14,    (6 << 4)      @ 14 Bits/Transfer bit-mask.
.equ  _BITS15,    (7 << 4)      @ 15 Bits/Transfer bit-mask.
.equ  _BITS16,    (8 << 4)      @ 16 Bits/Transfer bit-mask.
.equ  _CSAAT,     (1 << 3)      @ Chip Select Active After Transfer bit-position.
.equ  _CSNAAT,    (1 << 2)      @ Chip Select NOT Active Aftr Transfer bit-position.
.equ  _NCPHA,     (1 << 1)      @ Clock Phase bit-position.
.equ  _CPOL,      (1 << 0)      @ Clock Polarity bit-position.
@ SPI Write Protection Mode Register bit-field definitions.
.equ  _SPIWPKEY,  0X53504900    @ Write Protection Key (PASSWD).
.equ  _WPEN,      (1 << 0)      @ Write Protection Enable bit-position.
@ SPI Write Protection Status Register bit-field definitions.
.equ  _WPVS,      (1 << 0)      @ Write Protection Violation Status bit-position.
@ SPI PDC Transfer Control and Status Registers bit-field definitions.
.equ  _RXTEN,     0B0000000000000001
.equ  _RXTDIS,    0B0000000000000010
.equ  _TXTEN,     0B0000000100000000
.equ  _TXTDIS,    0B0000001000000000
@-----------------------------------------------------------------------------
@ Timer/Counter Controller offsets from group base address.
.equ  _TCCCRV,        0X0000      @ Channel Control Register offset.
.equ  _TCCMRV,        0X0004      @ Channel Mode Register offset.
.equ  _TCSMMRV,       0X0008      @ Stepper Motor Mode Register offset.
.equ  _TCCVRV,        0X0010      @ Counter Value Register offset.
.equ  _TCRAV,         0X0014      @ Register A offset.
.equ  _TCRBV,         0X0018      @ Register B offset.
.equ  _TCRCV,         0X001C      @ Register C offset.
.equ  _TCSRV,         0X0020      @ Status Register offset.
.equ  _TCIERV,        0X0024      @ Interrupt Enable Register offset.
.equ  _TCIDRV,        0X0028      @ Interrupt Disable Register offset.
.equ  _TCIMRV,        0X002C      @ Interrupt Mask Register offset.
.equ  _TCBCRV,        0X00C0      @ Block Control Register offset.
.equ  _TCBMRV,        0X00C4      @ Block Mode Register offset.
.equ  _TCQIERV,       0X00C8      @ QDEC Interrupt Enable Register offset.
.equ  _TCQIDRV,       0X00CC      @ QDEC Interrupt Disable Register offset.
.equ  _TCQIMRV,       0X00D0      @ QDEC Interrupt Mask Register offset.
.equ  _TCQISRV,       0X00D4      @ QDEC Interrupt Status Register offset.
.equ  _TCFMRV,        0X00D8      @ Fault Mode Register offset.
.equ  _TCWPMRV,       0X00E4      @ Write Protect Mode Register offset.
@-----------------------------------------------------------------------------
@ Timer/Counter Controller Register definitions.
.equ  _TC0,         0X4000C000
.equ  _TC0_0,       (_TC0 + 0X0000)
.equ  _TC0_1,       (_TC0 + 0X0040)
.equ  _TC0_2,       (_TC0 + 0X0080)
.equ  _TC1,         0X40010000
.equ  _TC1_0,       (_TC1 + 0X0000)
.equ  _TC1_1,       (_TC1 + 0X0040)
.equ  _TC1_2,       (_TC1 + 0X0080)
.equ  _TC2,         0X40014000
.equ  _TC2_0,       (_TC2 + 0X0000)
.equ  _TC2_1,       (_TC2 + 0X0040)
.equ  _TC2_2,       (_TC2 + 0X0080)
.equ  _TCCCR,       (_TC0 + _TCCCRV)      @ Channel Control Register.
.equ  _TCCMR,       (_TC0 + _TCCMRV)      @ Channel Mode Register.
.equ  _TCSMMR,      (_TC0 + _TCSMMRV)     @ Stepper Motor Mode Register.
.equ  _TCCVR,       (_TC0 + _TCCVRV)      @ Counter Value Register.
.equ  _TCRA,        (_TC0 + _TCRAV)       @ Register A.
.equ  _TCRB,        (_TC0 + _TCRBV)       @ Register B.
.equ  _TCRC,        (_TC0 + _TCRCV)       @ Register C.
.equ  _TCSR,        (_TC0 + _TCSRV)       @ Status Register.
.equ  _TCIER,       (_TC0 + _TCIERV)      @ Interrupt Enable Register.
.equ  _TCIDR,       (_TC0 + _TCIDRV)      @ Interrupt Disable Register.
.equ  _TCIMR,       (_TC0 + _TCIMRV)      @ Interrupt Mask Register.
.equ  _TCBCR,       (_TC0 + _TCBCRV)      @ Block Control Register.
.equ  _TCBMR,       (_TC0 + _TCBMRV)      @ Block Mode Register.
.equ  _TCQIER,      (_TC0 + _TCQIERV)     @ QDEC Interrupt Enable Register.
.equ  _TCQIDR,      (_TC0 + _TCQIDRV)     @ QDEC Interrupt Disable Register.
.equ  _TCQIMR,      (_TC0 + _TCQIMRV)     @ QDEC Interrupt Mask Register.
.equ  _TCQISR,      (_TC0 + _TCQISRV)     @ QDEC Interrupt Status Register.
.equ  _TCFMR,       (_TC0 + _TCFMRV)      @ Fault Mode Register.
.equ  _TCWPMR,      (_TC0 + _TCWPMRV)     @ Write Protect Mode Register.
@-----------------------------------------------------------------------------
@ Timer/Counter Register bit-field definitions.
@ Block Control Register.
.equ  _TCSYNC,        (1 << 0)            @ Synchro Command.
@ Block Mode Register.
.equ  _TC0XC0S,       (3 << 0)            @ External Clock Signal 0 Selection mask.
.equ  _TCLK00,        (0 << 0)            @ Signal connected to XC0: TCLK0.
.equ  _TIO0A1,        (2 << 0)            @ Signal connected to XC0: TIOA1.
.equ  _TIO0A2,        (3 << 0)            @ Signal connected to XC0: TIOA2.
.equ  _TC1XC1S,       (3 << 2)            @ External Clock Signal 1 Selection mask.
.equ  _TCLK10,        (0 << 2)            @ Signal connected to XC1: TCLK0.
.equ  _TIO1A0,        (2 << 2)            @ Signal connected to XC1: TIOA0.
.equ  _TIO1A2,        (3 << 2)            @ Signal connected to XC1: TIOA2.
.equ  _TC2XC2S,       (3 << 4)            @ External Clock Signal 2 Selection mask.
.equ  _TCLK20,        (0 << 4)            @ Signal connected to XC2: TCLK0.
.equ  _TIO2A1,        (2 << 4)            @ Signal connected to XC2: TIOA1.
.equ  _TIO2A2,        (3 << 4)            @ Signal connected to XC2: TIOA2.
.equ  _QDEN,          (1 << 8)            @ Quadrature Decoder Enabled.
.equ  _POSEN,         (1 << 9)            @ Position Enabled.
.equ  _SPEEDEN,       (1 << 10)           @ Speed Enabled.
.equ  _QDTRANS,       (1 << 11)           @ Quadrature Decodint Transparent.
.equ  _EDGPHA,        (1 << 12)           @ Edge on Phase A count mode.
.equ  _INVA,          (1 << 13)           @ Inverted Phase A.
.equ  _INVB,          (1 << 14)           @ Inverted Phase B.
.equ  _INVIDX,        (1 << 15)           @ Inverted Index.
.equ  _SWAP,          (1 << 16)           @ Swap Phase A and Phase B.
.equ  _IDXPHB,        (1 << 17)           @ Index pin is Phase B pin.
.equ  _FILTER,        (1 << 19)           @ Filter Enabled.
@ Quadrature Encoder.
.equ  _IEIDX,         (1 << 0)            @ Enable interrupt on rising edge.
.equ  _DIRCHG,        (1 << 1)            @ Enable interrupt on rotation change.
.equ  _QERR,          (1 << 2)            @ Enable interrupt on quadrature error.
.equ  _QDIR,          (1 << 8)            @ Quadrature direction.
@ Fault Mode.
.equ  _ENCF0,         (1 << 0)            @ Enable Compare Fault Channel 0.
.equ  _ENCF1,         (1 << 1)            @ Enable Compare Fault Channel 1.
@ Write Protect Mode.
.equ  _WPEN,          (1 << 0)            @ Write Protection Enable.
.equ  _TCWPKEY,       (0X54494D << 8)     @ Write Protection Key.
@ Channel Control Register.
.equ  _CLKEN,         (1 << 0)            @ Counter Clock Enable.
.equ  _CLKDIS,        (1 << 1)            @ Counter Clock Disable.
.equ  _SWTRG,         (1 << 2)            @ Software Trigger.
@ Channel Mode Register: Capture Mode.
.equ  _TCLK1,         (0 << 0)            @ Clock Selected: TCLK1.
.equ  _TCLK2,         (1 << 0)            @ Clock Selected: TCLK2.
.equ  _TCLK3,         (2 << 0)            @ Clock Selected: TCLK3.
.equ  _TCLK4,         (3 << 0)            @ Clock Selected: TCLK4.
.equ  _TCLK5,         (4 << 0)            @ Clock Selected: TCLK5.
.equ  _XC0,           (5 << 0)            @ Clock Selected: XC0.
.equ  _XC1,           (6 << 0)            @ Clock Selected: XC1.
.equ  _XC2,           (7 << 0)            @ Clock Selected: XC2.
.equ  _CLKI,          (1 << 3)            @ Clock Invert.
.equ  _BURST_XC0,     (1 << 4)            @ XC0 ANDed with selected clock.
.equ  _BURST_XC1,     (2 << 4)            @ XC1 ANDed with selected clock.
.equ  _BURST_XC2,     (3 << 4)            @ XC2 ANDed with selected clock.
.equ  _LDBSTOP,       (1 << 6)            @ Counter Clock Stopped with RB Loading.
.equ  _LDBDIS,        (1 << 7)            @ Counter Clock Disable with RB Loading.
.equ  _EXTRISING,     (1 << 8)            @ External Trigger on Rising Edge.
.equ  _EXTFALLING,    (2 << 8)            @ External Trigger on Falling Edge.
.equ  _EXTEDGE,       (3 << 8)            @ External Trigger on Each Edge.
.equ  _ABETRG,        (1 << 10)           @ TIOA or TIOB External Trigger Selection.
.equ  _CPCTRG,        (1 << 14)           @ RC Compare Trigger Enable.
.equ  _WAVEUP,        (0 << 13)           @ Wave Select UP.
.equ  _WAVEUPDN,      (1 << 13)           @ Wave Select UP-DOWN.
.equ  _WAVEUPRC,      (2 << 13)           @ Wave Select UP-RC.
.equ  _WAVEUPDNRC,    (3 << 13)           @ Wave Select UP-DOWN-RC.
.equ  _WAVE,          (1 << 15)           @ Capture Mode.
.equ  _RARISING,      (1 << 16)           @ RA Loading on Rising Edge.
.equ  _RAFALLING,     (2 << 16)           @ RA Loading on Falling Edge.
.equ  _RAEDGE,        (3 << 16)           @ RA Loading on Each Edge.
.equ  _RBRISING,      (1 << 18)           @ RB Loading on Rising Edge.
.equ  _RBFALLING,     (2 << 18)           @ RB Loading on Falling Edge.
.equ  _RBEDGE,        (3 << 18)           @ RB Loading on Each Edge.
@ TC Status Register.
.equ  _COVFS,         (1 << 0)            @ Counter Overflow Status.
.equ  _LOVRS,         (1 << 1)            @ LOAD Overrun Status.
.equ  _CPAS,          (1 << 2)            @ RA Compare Status.
.equ  _CPBS,          (1 << 3)            @ RB Compare Status.
.equ  _CPCS,          (1 << 4)            @ RC Compare Status.
.equ  _LDRAS,         (1 << 5)            @ RA Loading Status.
.equ  _LDRBS,         (1 << 6)            @ RB Loading Status.
.equ  _ETRGS,         (1 << 7)            @ External Trigger Status.
.equ  _CLKSTA,        (1 << 16)           @ Clock Enabling Status.
.equ  _MTIOA,         (1 << 17)           @ TIOA Mirror.
.equ  _MTIOB,         (1 << 18)           @ TIOB Mirror.
@-----------------------------------------------------------------------------
@ Two Wire Interface Controller offsets from group base address.
.equ  _TWICRV,        0X0000      @ Control Register offset.
.equ  _TWIMMRV,       0X0004      @ Master Mode Register offset.
.equ  _TWISMRV,       0X0008      @ Slave Mode Register offset.
.equ  _TWIIADRV,      0X000C      @ Internal Address Register offset.
.equ  _TWICWGRV,      0X0010      @ Clock Waveform Generator Register offset.
.equ  _TWISRV,        0X0020      @ Status Register offset.
.equ  _TWIIERV,       0X0024      @ Interrupt Enable Register offset.
.equ  _TWIIDRV,       0X0028      @ Interrupt Disable Register offset.
.equ  _TWIIMRV,       0X002C      @ Interrupt Mask Register offset.
.equ  _TWIRHRV,       0X0030      @ Receive Holding Register offset.
.equ  _TWITHRV,       0X0034      @ Transmit Holding Register offset.
.equ  _TWISMBTRV,     0x0038      @ SMBus Timing Register offset.
.equ  _TWIFILTRV,     0X0044      @ Filter Register offset.
.equ  _TWISWMRV,      0X004C      @ SleepWalking Matching Register offset.
.equ  _TWIWPMRV,      0X00E4      @ Write Protection Mode Register offset.
.equ  _TWIWPSRV,      0X00E8      @ Write Protection Status Register offset.
@-----------------------------------------------------------------------------
@ Two Wire Interface Controller Register definitions.
.equ  _TWI0,        0X40018000            @ TWI-0 register group base address.
.equ  _TWI0CR,      (_TWI0 + _TWICRV)     @ Control Register.
.equ  _TWI0MMR,     (_TWI0 + _TWIMMRV)    @ Master Mode Register.
.equ  _TWI0SMR,     (_TWI0 + _TWISMRV)    @ Slave Mode Register.
.equ  _TWI0IADR,    (_TWI0 + _TWIIADRV)   @ Internal Address Register.
.equ  _TWI0CWGR,    (_TWI0 + _TWICWGRV)   @ Clock Waveform Generator Register.
.equ  _TWI0SR,      (_TWI0 + _TWISRV)     @ Status Register.
.equ  _TWI0IER,     (_TWI0 + _TWIIERV)    @ Interrupt Enable Register.
.equ  _TWI0IDR,     (_TWI0 + _TWIIDRV)    @ Interrupt Disable Register.
.equ  _TWI0IMR,     (_TWI0 + _TWIIMRV)    @ Interrupt Mask Register.
.equ  _TWI0RHR,     (_TWI0 + _TWIRHRV)    @ Receive Holding Register.
.equ  _TWI0THR,     (_TWI0 + _TWITHRV)    @ Transmit Holding Register.
.equ  _TWI0SMBTR,   (_TWI0 + _TWISMBTRV)  @ SMBus Timing Register.
.equ  _TWI0FILTR,   (_TWI0 + _TWIFILTRV)  @ Filter Register.
.equ  _TWI0SWMR,    (_TWI0 + _TWISWMRV)   @ SleepWalking Matching Register.
.equ  _TWI0WPMR,    (_TWI0 + _TWIWPMRV)   @ Write Protection Mode Register.
.equ  _TWI0WPSR,    (_TWI0 + _TWIWPSRV)   @ Write Protection Status Register.
.equ  _TWI1,        0X4001C000            @ TWI-1 register group base address.
.equ  _TWI1CR,      (_TWI1 + _TWICRV)     @ Control Register.
.equ  _TWI1MMR,     (_TWI1 + _TWIMMRV)    @ Master Mode Register.
.equ  _TWI1SMR,     (_TWI1 + _TWISMRV)    @ Slave Mode Register.
.equ  _TWI1IADR,    (_TWI1 + _TWIIADRV)   @ Internal Address Register.
.equ  _TWI1CWGR,    (_TWI1 + _TWICWGRV)   @ Clock Waveform Generator Register.
.equ  _TWI1SR,      (_TWI1 + _TWISRV)     @ Status Register.
.equ  _TWI1IER,     (_TWI1 + _TWIIERV)    @ Interrupt Enable Register.
.equ  _TWI1IDR,     (_TWI1 + _TWIIDRV)    @ Interrupt Disable Register.
.equ  _TWI1IMR,     (_TWI1 + _TWIIMRV)    @ Interrupt Mask Register.
.equ  _TWI1RHR,     (_TWI1 + _TWIRHRV)    @ Receive Holding Register.
.equ  _TWI1THR,     (_TWI1 + _TWITHRV)    @ Transmit Holding Register.
.equ  _TWI1SMBTR,   (_TWI1 + _TWISMBTRV)  @ SMBus Timing Register.
.equ  _TWI1FILTR,   (_TWI1 + _TWIFILTRV)  @ Filter Register.
.equ  _TWI1SWMR,    (_TWI1 + _TWISWMRV)   @ SleepWalking Matching Register.
.equ  _TWI1WPMR,    (_TWI1 + _TWIWPMRV)   @ Write Protection Mode Register.
.equ  _TWI1WPSR,    (_TWI1 + _TWIWPSRV)   @ Write Protection Status Register.
.equ  _TWI2,        0X40060000            @ TWI-2 register group base address.
.equ  _TWI2CR,      (_TWI2 + _TWICRV)     @ Control Register.
.equ  _TWI2MMR,     (_TWI2 + _TWIMMRV)    @ Master Mode Register.
.equ  _TWI2SMR,     (_TWI2 + _TWISMRV)    @ Slave Mode Register.
.equ  _TWI2IADR,    (_TWI2 + _TWIIADRV)   @ Internal Address Register.
.equ  _TWI2CWGR,    (_TWI2 + _TWICWGRV)   @ Clock Waveform Generator Register.
.equ  _TWI2SR,      (_TWI2 + _TWISRV)     @ Status Register.
.equ  _TWI2IER,     (_TWI2 + _TWIIERV)    @ Interrupt Enable Register.
.equ  _TWI2IDR,     (_TWI2 + _TWIIDRV)    @ Interrupt Disable Register.
.equ  _TWI2IMR,     (_TWI2 + _TWIIMRV)    @ Interrupt Mask Register.
.equ  _TWI2RHR,     (_TWI2 + _TWIRHRV)    @ Receive Holding Register.
.equ  _TWI2THR,     (_TWI2 + _TWITHRV)    @ Transmit Holding Register.
.equ  _TWI2SMBTR,   (_TWI2 + _TWISMBTRV)  @ SMBus Timing Register.
.equ  _TWI2FILTR,   (_TWI2 + _TWIFILTRV)  @ Filter Register.
.equ  _TWI2SWMR,    (_TWI2 + _TWISWMRV)   @ SleepWalking Matching Register.
.equ  _TWI2WPMR,    (_TWI2 + _TWIWPMRV)   @ Write Protection Mode Register.
.equ  _TWI2WPSR,    (_TWI2 + _TWIWPSRV)   @ Write Protection Status Register.
@-----------------------------------------------------------------------------
@ TWIHS Register bit-field definitions.
@ TWIHS_CR Control Register.
.equ  _TWSTART,       (1 << 0)      @ Send Start condition.
.equ  _TWSTOP,        (1 << 1)      @ Send Stop condition.
.equ  _TWMSEN,        (1 << 2)      @ Master Mode Enabled.
.equ  _TWMSDIS,       (1 << 3)      @ Master Mode Disabled.
.equ  _TWSVEN,        (1 << 4)      @ Slave Mode Enabled.
.equ  _TWSVDIS,       (1 << 5)      @ Slave Mode Disabled.
.equ  _TWQUICK,       (1 << 6)      @ SMBUS Quick command.
.equ  _TWSWRST,       (1 << 7)      @ Software Reset.
.equ  _TWHSEN,        (1 << 8)      @ High-Speed Mode Enabled.
.equ  _TWHSDIS,       (1 << 9)      @ High-Speeg Mode Disabled.
.equ  _TWSMBEN,       (1 << 10)     @ SMBus Mode Enabled.
.equ  _TWSMBDIS,      (1 << 11)     @ SMBus Mode Disabled.
.equ  _TWPECEN,       (1 << 12)     @ Packet Error Checking Enable.
.equ  _TWPECDIS,      (1 << 13)     @ Packet Error Checking Disable
.equ  _TWPECRQ,       (1 << 14)     @ PEC Request.
.equ  _TWCLEAR,       (1 << 15)     @ Bus Clear Command.
.equ  _TWACMEN,       (1 << 16)     @ Alternative Command Mode Enable.
.equ  _TWACMDIS,      (1 << 17)     @ Alternative Command Mode Disable
.equ  _TWTHRCLR,      (1 << 24)     @ Transmit Holding Register Clear.
.equ  _TWLOCKCLR,     (1 << 26)     @ Lock Clear.
.equ  _TWFIFOEN,      (1 << 28)     @ FIFO Enable.
.equ  _TWFIFODIS,     (1 << 29)     @ FIFO Disable.
@ TWIHS_MR Mode Register.
.equ  _TWADDRSZMSK,   (3 << 8)      @ Internal device address size bit-mask.
.equ  _TWADDRSZNONE,  (0 << 8)      @ No internal device address.
.equ  _TWADDRSZ1B,    (1 << 8)      @ One-byte internal device address.
.equ  _TWADDRSZ2B,    (2 << 8)      @ Two-byte internal device address.
.equ  _TWADDRSZ3B,    (3 << 8)      @ Three-byte internal device address.
.equ  _TWMREAD,       (1 << 12)     @ Master Read Direction.
.equ  _TWDADRPOS,     16            @ Device address bits position.
.equ  _TWDADRMSK,     (0X7F << 12)  @ Device address bit-mask.
@ TWIHS_SMR Slave Mode Register.
.equ  _TWNAXKEN,      (1 << 0)      @ Slave Receiver Data Phase NACK Enable.
.equ  _TWSMDA,        (1 << 2)      @ SMBus Default Address.
.equ  _TWSMHH,        (1 << 3)      @ SMBus Host Header.
.equ  _TWSCLWSDIS,    (1 << 6)      @ Clock Wait State Disable.
.equ  _TWMASKPOS,     8             @ Slave Address Mask bits position.
.equ  _TWMASKMSK,     (0X7F << 8)   @ Slave Address Mask bit-mask.
.equ  _TWSADRPOS,     16            @ Slave Address bits position.
.equ  _TWSADRMSK,     (0X7F << 16)  @ Slave Address bit-mask.
.equ  _TWSADR1EN,     (1 << 28)     @ Slave Address 1 Enable.
.equ  _TWSADR2EN,     (1 << 29)     @ Slave Address 2 Enable.
.equ  _TWSADR3EN,     (1 << 30)     @ Slave Address 3 Enable.
.equ  _TWDATAMEN,     (1 << 31)     @ Data Matching Enable.
@ TWIHS_CWGR Clock Waveform Generator Register.
.equ  _TWCLDIVMSK,    (0XFF << 0)   @ Clock Low Divider bit-mask.
.equ  _TWCHDIVMSK,    (0XFF << 8)   @ Clock Hich Divider bit-mask.
.equ  _TWCKDIVMSK,    (0X07 << 16)  @ Clock Divider.
.equ  _TWCKSRC,       (1 << 20)     @ Transfer Rate Clock Source.
.equ  _TWHOLDMSK,     (0X1F << 24)  @ TWD Hold Time Vs TWCK Falling bit-mask.
@ TWIHS_SR Status Register.
.equ  _TWTXCOMP,      (1 << 0)      @ Transmission Completed.
.equ  _TWRXRDY,       (1 << 1)      @ Receive Holding Register Ready.
.equ  _TWTXRDY,       (1 << 2)      @ Transmit Holding Register Ready.
.equ  _TWSVREAD,      (1 << 3)      @ Slave Read.
.equ  _TWSVACC,       (1 << 4)      @ Slave Access.
.equ  _TWGACC,        (1 << 5)      @ General Call Access.
.equ  _TWTWOVRE,      (1 << 6)      @ Overrun Error.
.equ  _TWUNRE,        (1 << 7)      @ Underrun Error.
.equ  _TWNACK,        (1 << 8)      @ Not Acknowledged.
.equ  _TWARBLST,      (1 << 9)      @ Arbitration Lost.
.equ  _TWSCLWS,       (1 << 10)     @ Clock Wait State.
.equ  _TWEOSACC,      (1 << 11)     @ End Of Slave Access.
.equ  _TWMCACK,       (1 << 16)     @ Master Code Acknowledge.
.equ  _TWTOUT,        (1 << 18)     @ Timeout Error.
.equ  _TWPECERR,      (1 << 19)     @ PEC Error.
.equ  _TWSMBDAM,      (1 << 20)     @ SMBus Default Address Match.
.equ  _TWSMBHHM,      (1 << 21)     @ SMBus Host Header Address Match.
.equ  _TWSCL,         (1 << 24)     @ SCL Line Value.
.equ  _TWSDA,         (1 << 25)     @ SDA Line Value.
@ TWIHS_WPMR Write Protection Mode Register.
.equ  _TWWPKEY,       0X54574900    @ Write Protection Key (PASSWD).
.equ  _TWWPEN,        (1 << 0)      @ Write Protection Enable.
@-----------------------------------------------------------------------------
@ Pulse Width Modulation Controller offsets from group base address.
.equ  _PWMCLKV,       0X0000      @ Clock Register offset.
.equ  _PWMENAV,       0X0004      @ Enable Register offset.
.equ  _PWMDISV,       0X0008      @ Disable Register offset.
.equ  _PWMSRV,        0X000C      @ Status Register offset.
.equ  _PWMIER1V,      0X0010      @ Interrupt Enable Register 1 offset.
.equ  _PWMIDR1V,      0X0014      @ Interrupt Disable Register 1 offset.
.equ  _PWMIMR1V,      0X0018      @ Interrupt Mask Register 1 offset.
.equ  _PWMISR1V,      0X001C      @ Interrupt Status Register 1 offset.
.equ  _PWMSCMV,       0X0020      @ Sync Channels Mode Register offset.
.equ  _PWMDMARV,      0X0024      @ DMA Register offset.
.equ  _PWMSCUCV,      0X0028      @ Sync Channels Update Control Register offset.
.equ  _PWMSCUPV,      0X002C      @ Sync Channels Update Period Register offset.
.equ  _PWMSCUPUV,     0X0030      @ Sync Channels Update Period Update Register offset.
.equ  _PWMIER2V,      0X0034      @ Interrupt Enable Register 2 offset.
.equ  _PWMIDR2V,      0X0038      @ Interrupt Disable Register 2 offset.
.equ  _PWMIMR2V,      0X003C      @ Interrupt Mask Register 2 offset.
.equ  _PWMISR2V,      0X0040      @ Interrupt Status Register 2 offset.
.equ  _PWMOOVV,       0X0044      @ Output Override Value Register offset.
.equ  _PWMOSV,        0X0048      @ Output Selection Register offset.
.equ  _PWMOSSV,       0X004C      @ Output Selection Set Register offset.
.equ  _PWMOSCV,       0X0050      @ Output Selection Clear Register offset.
.equ  _PWMOSSUV,      0X0054      @ Output Selection Set Update Register offset.
.equ  _PWMOSCUV,      0X0058      @ Output Selection Clear Update Register offset.
.equ  _PWMFMRV,       0X005C      @ Fault Mode Register offset.
.equ  _PWMFSRV,       0X0060      @ Fault Status Register offset.
.equ  _PWMFCRV,       0X0064      @ Fault Clear Register offset.
.equ  _PWMFPVV,       0X0068      @ Fault Protection Value Register offset.
.equ  _PWMFPE1V,      0X006C      @ Fault Protection Enable Register 1 offset.
.equ  _PWMFPE2V,      0X0070      @ Fault Protection Enable Register 2 offset.
.equ  _PWMEL0MV,      0X007C      @ Event Line 0 Mode Register offset.
.equ  _PWMEL1MV,      0X0080      @ Event Line 1 Mode Register offset.
.equ  _PWMSMMRV,      0X00B0      @ Stepper Motor Mode Register offset.
.equ  _PWMWPCV,       0X00E4      @ Write Protect Control Register offset.
.equ  _PWMWPSV,       0X00E8      @ Write Protect Status Register offset.
.equ  _PWMCMP0V,      0X0130      @ Comparison 0 Value Register offset.
.equ  _PWMCMP0UV,     0X0134      @ Comparison 0 Value Update Register offset.
.equ  _PWMCMP0MV,     0X0138      @ Comparison 0 Mode Register offset.
.equ  _PWMCMP0MUV,    0X013C      @ Comparison 0 Mode Update Register offset.
.equ  _PWMCMP1V,      0X0140      @ Comparison 1 Value Register offset.
.equ  _PWMCMP1UV,     0X0144      @ Comparison 1 Value Update Register offset.
.equ  _PWMCMP1MV,     0X0148      @ Comparison 1 Mode Register offset.
.equ  _PWMCMP1MUV,    0X014C      @ Comparison 1 Mode Update Register offset.
.equ  _PWMCMP2V,      0X0150      @ Comparison 2 Value Register offset.
.equ  _PWMCMP2UV,     0X0154      @ Comparison 2 Value Update Register offset.
.equ  _PWMCMP2MV,     0X0158      @ Comparison 2 Mode Register offset.
.equ  _PWMCMP2MUV,    0X015C      @ Comparison 2 Mode Update Register offset.
.equ  _PWMCMP3V,      0X0160      @ Comparison 3 Value Register offset.
.equ  _PWMCMP3UV,     0X0164      @ Comparison 3 Value Update Register offset.
.equ  _PWMCMP3MV,     0X0168      @ Comparison 3 Mode Register offset.
.equ  _PWMCMP3MUV,    0X016C      @ Comparison 3 Mode Update Register offset.
.equ  _PWMCMP4V,      0X0170      @ Comparison 4 Value Register offset.
.equ  _PWMCMP4UV,     0X0174      @ Comparison 4 Value Update Register offset.
.equ  _PWMCMP4MV,     0X0178      @ Comparison 4 Mode Register offset.
.equ  _PWMCMP4MUV,    0X017C      @ Comparison 4 Mode Update Register offset.
.equ  _PWMCMP5V,      0X0180      @ Comparison 5 Value Register offset.
.equ  _PWMCMP5UV,     0X0184      @ Comparison 5 Value Update Register offset.
.equ  _PWMCMP5MV,     0X0188      @ Comparison 5 Mode Register offset.
.equ  _PWMCMP5MUV,    0X018C      @ Comparison 5 Mode Update Register offset.
.equ  _PWMCMP6V,      0X0190      @ Comparison 6 Value Register offset.
.equ  _PWMCMP6UV,     0X0194      @ Comparison 6 Value Update Register offset.
.equ  _PWMCMP6MV,     0X0198      @ Comparison 6 Mode Register offset.
.equ  _PWMCMP6MUV,    0X019C      @ Comparison 6 Mode Update Register offset.
.equ  _PWMCMP7V,      0X01A0      @ Comparison 7 Value Register offset.
.equ  _PWMCMP7UV,     0X01A4      @ Comparison 7 Value Update Register offset.
.equ  _PWMCMP7MV,     0X01A8      @ Comparison 7 Mode Register offset.
.equ  _PWMCMP7MUV,    0X01AC      @ Comparison 7 Mode Update Register offset.
.equ  _PWMCMV,        0X0200      @ Channel Mode Register offset.
.equ  _PWMCDCV,       0X0204      @ Channel Duty Cycle Register offset.
.equ  _PWMCDCUV,      0X0208      @ Channel Duty Cycle Update Register offset.
.equ  _PWMCPV,        0X020C      @ Channel Period Register offset.
.equ  _PWMCPUV,       0X0210      @ Channel Period Update Register offset.
.equ  _PWMCCV,        0X0214      @ Channel Counter Register offset.
.equ  _PWMDTV,        0X0218      @ Channel Dead Time Register offset.
.equ  _PWMCDUV,       0X021C      @ Channel Dead Time Update Register offset.
@-----------------------------------------------------------------------------
@ Pulse Width Modulation Controller Register definitions.
.equ  _PWM,         0X40020000
.equ  _PWMCLK,      (_PWM + _PWMCLKV)     @ Clock Register.
.equ  _PWMENA,      (_PWM + _PWMENAV)     @ Enable Register.
.equ  _PWMDIS,      (_PWM + _PWMDISV)     @ Disable Register.
.equ  _PWMSR,       (_PWM + _PWMSRV)      @ Status Register.
.equ  _PWMIER1,     (_PWM + _PWMIER1V)    @ Interrupt Enable Register 1.
.equ  _PWMIDR1,     (_PWM + _PWMIDR1V)    @ Interrupt Disable Register 1.
.equ  _PWMIMR1,     (_PWM + _PWMIMR1V)    @ Interrupt Mask Register 1.
.equ  _PWMISR1,     (_PWM + _PWMISR1V)    @ Interrupt Status Register 1.
.equ  _PWMSCM,      (_PWM + _PWMSCMV)     @ Sync Channels Mode Register.
.equ  _PWMSCUC,     (_PWM + _PWMSCUCV)    @ Sync Channels Update Control Register.
.equ  _PWMSCUP,     (_PWM + _PWMSCUPV)    @ Sync Channels Update Period Register.
.equ  _PWMSCUPU,    (_PWM + _PWMSCUPUV)   @ Sync Channels Update Period Update Register.
.equ  _PWMIER2,     (_PWM + _PWMIER2V)    @ Interrupt Enable Register 2.
.equ  _PWMIDR2,     (_PWM + _PWMIDR2V)    @ Interrupt Disable Register 2.
.equ  _PWMIMR2,     (_PWM + _PWMIMR2V)    @ Interrupt Mask Register 2.
.equ  _PWMISR2,     (_PWM + _PWMISR2V)    @ Interrupt Status Register 2.
.equ  _PWMOOV,      (_PWM + _PWMOOVV)     @ Output Override Value Register.
.equ  _PWMOS,       (_PWM + _PWMOSV)      @ Output Selection Register.
.equ  _PWMOSS,      (_PWM + _PWMOSSV)     @ Output Selection Set Register.
.equ  _PWMOSC,      (_PWM + _PWMOSCV)     @ Output Selection Clear Register.
.equ  _PWMOSSU,     (_PWM + _PWMOSSUV)    @ Output Selection Set Update Register.
.equ  _PWMOSCU,     (_PWM + _PWMOSCUV)    @ Output Selection Clear Update Register.
.equ  _PWMFMR,      (_PWM + _PWMFMRV)     @ Fault Mode Register.
.equ  _PWMFSR,      (_PWM + _PWMFSRV)     @ Fault Status Register.
.equ  _PWMFCR,      (_PWM + _PWMFCRV)     @ Fault Clear Register.
.equ  _PWMFPV,      (_PWM + _PWMFPVV)     @ Fault Protection Value Register.
.equ  _PWMFPE1,     (_PWM + _PWMFPE1V)    @ Fault Protection Enable Register 1.
.equ  _PWMFPE2,     (_PWM + _PWMFPE2V)    @ Fault Protection Enable Register 2.
.equ  _PWMEL0M,     (_PWM + _PWMEL0MV)    @ Event Line 0 Mode Register.
.equ  _PWMEL1M,     (_PWM + _PWMEL1MV)    @ Event Line 1 Mode Register.
.equ  _PWMSMMR,     (_PWM + _PWMSMMRV)    @ Stepper Motor Mode Register.
.equ  _PWMWPC,      (_PWM + _PWMWPCV)     @ Write Protect Control Register.
.equ  _PWMWPS,      (_PWM + _PWMWPSV)     @ Write Protect Status Register.
.equ  _PWMCMP0,     (_PWM + _PWMCMP0V)    @ Comparison 0 Value Register.
.equ  _PWMCMP0U,    (_PWM + _PWMCMP0UV)   @ Comparison 0 Value Update Register.
.equ  _PWMCMP0M,    (_PWM + _PWMCMP0MV)   @ Comparison 0 Mode Register.
.equ  _PWMCMP0MU,   (_PWM + _PWMCMP0MUV)  @ Comparison 0 Mode Update Register.
.equ  _PWMCMP1,     (_PWM + _PWMCMP1V)    @ Comparison 1 Value Register.
.equ  _PWMCMP1U,    (_PWM + _PWMCMP1UV)   @ Comparison 1 Value Update Register.
.equ  _PWMCMP1M,    (_PWM + _PWMCMP1MV)   @ Comparison 1 Mode Register.
.equ  _PWMCMP1MU,   (_PWM + _PWMCMP1MUV)  @ Comparison 1 Mode Update Register.
.equ  _PWMCMP2,     (_PWM + _PWMCMP2V)    @ Comparison 2 Value Register.
.equ  _PWMCMP2U,    (_PWM + _PWMCMP2UV)   @ Comparison 2 Value Update Register.
.equ  _PWMCMP2M,    (_PWM + _PWMCMP2MV)   @ Comparison 2 Mode Register.
.equ  _PWMCMP2MU,   (_PWM + _PWMCMP2MUV)  @ Comparison 2 Mode Update Register.
.equ  _PWMCMP3,     (_PWM + _PWMCMP3V)    @ Comparison 3 Value Register.
.equ  _PWMCMP3U,    (_PWM + _PWMCMP3UV)   @ Comparison 3 Value Update Register.
.equ  _PWMCMP3M,    (_PWM + _PWMCMP3MV)   @ Comparison 3 Mode Register.
.equ  _PWMCMP3MU,   (_PWM + _PWMCMP3MUV)  @ Comparison 3 Mode Update Register.
.equ  _PWMCMP4,     (_PWM + _PWMCMP4V)    @ Comparison 4 Value Register.
.equ  _PWMCMP4U,    (_PWM + _PWMCMP4UV)   @ Comparison 4 Value Update Register.
.equ  _PWMCMP4M,    (_PWM + _PWMCMP4MV)   @ Comparison 4 Mode Register.
.equ  _PWMCMP4MU,   (_PWM + _PWMCMP4MUV)  @ Comparison 4 Mode Update Register.
.equ  _PWMCMP5,     (_PWM + _PWMCMP5V)    @ Comparison 5 Value Register.
.equ  _PWMCMP5U,    (_PWM + _PWMCMP5UV)   @ Comparison 5 Value Update Register.
.equ  _PWMCMP5M,    (_PWM + _PWMCMP5MV)   @ Comparison 5 Mode Register.
.equ  _PWMCMP5MU,   (_PWM + _PWMCMP5MUV)  @ Comparison 5 Mode Update Register.
.equ  _PWMCMP6,     (_PWM + _PWMCMP6V)    @ Comparison 6 Value Register.
.equ  _PWMCMP6U,    (_PWM + _PWMCMP6UV)   @ Comparison 6 Value Update Register.
.equ  _PWMCMP6M,    (_PWM + _PWMCMP6MV)   @ Comparison 6 Mode Register.
.equ  _PWMCMP6MU,   (_PWM + _PWMCMP6MUV)  @ Comparison 6 Mode Update Register.
.equ  _PWMCMP7,     (_PWM + _PWMCMP7V)    @ Comparison 7 Value Register.
.equ  _PWMCMP7U,    (_PWM + _PWMCMP7UV)   @ Comparison 7 Value Update Register.
.equ  _PWMCMP7M,    (_PWM + _PWMCMP7MV)   @ Comparison 7 Mode Register.
.equ  _PWMCMP7MU,   (_PWM + _PWMCMP7MUV)  @ Comparison 7 Mode Update Register.
.equ  _PWMCM,       (_PWM + _PWMCMV)      @ Channel Mode Register.
.equ  _PWMCMR0,     (_PWMCM + 0X00)       @ Channel 0 Mode Register.
.equ  _PWMCMR1,     (_PWMCM + 0X20)       @ Channel 1 Mode Register.
.equ  _PWMCMR2,     (_PWMCM + 0X40)       @ Channel 2 Mode Register.
.equ  _PWMCMR3,     (_PWMCM + 0X50)       @ Channel 3 Mode Register.
.equ  _PWMCMR4,     (_PWMCM + 0X80)       @ Channel 4 Mode Register.
.equ  _PWMCMR5,     (_PWMCM + 0XA0)       @ Channel 5 Mode Register.
.equ  _PWMCMR6,     (_PWMCM + 0XC0)       @ Channel 6 Mode Register.
.equ  _PWMCMR7,     (_PWMCM + 0XE0)       @ Channel 7 Mode Register.
.equ  _PWMCDC,      (_PWM + _PWMCDCV)     @ Channel Duty Cycle Register.
.equ  _PWMCDCU,     (_PWM + _PWMCDCUV)    @ Channel Duty Cycle Update Register.
.equ  _PWMCP,       (_PWM + _PWMCPV)      @ Channel Period Register.
.equ  _PWMCPU,      (_PWM + _PWMCPUV)     @ Channel Period Update Register.
.equ  _PWMCC,       (_PWM + _PWMCCV)      @ Channel Counter Register.
.equ  _PWMDT,       (_PWM + _PWMDTV)      @ Channel Dead Time Register.
.equ  _PWMCDU,      (_PWM + _PWMCDUV)     @ Channel Dead Time Update Register.
@-----------------------------------------------------------------------------
@ AFEC Register offsets from group base address.
.equ  _AFECCRV,       0X0000      @ Control Register offset.
.equ  _AFECMRV,       0X0004      @ Mode Register offset.
.equ  _AFECEMRV,      0X0008      @ Extended Mode Regiter offset.
.equ  _AFECSEQ1RV,    0X000C      @ Channel Sequence 1 Register offset.
.equ  _AFECSEQ2RV,    0X0010      @ Channel Sequence 2 Register offset.
.equ  _AFECCHERV,     0X0014      @ Channel Enable Register offset.
.equ  _AFECCHDRV,     0X0018      @ Channel Disable Register offset.
.equ  _AFECCHSRV,     0X001C      @ Channel Status Register offset.
.equ  _AFECLCDRV,     0X0020      @ Last Converted Data Register offset.
.equ  _AFECIERV,      0X0024      @ Interrupt Enable Register offset.
.equ  _AFECIDRV,      0X0028      @ Interrupt Disable Register offset.
.equ  _AFECIMRV,      0X002C      @ Interrupt Mask Register offset.
.equ  _AFECISRV,      0X0030      @ Interrupt Status Register offset.
.equ  _AFECOVERV,     0X004C      @ Overrun Status Register offset.
.equ  _AFECCWRV,      0X0050      @ Compare Window Register offset.
.equ  _AFECCGRV,      0X0054      @ Channel Gain Register offset.
.equ  _AFECDIFFRV,    0X0060      @ Channel Differential Register offset.
.equ  _AFECCSELRV,    0X0064      @ Channel Selection Register offset.
.equ  _AFECCDRV,      0X0068      @ Channel Data Register offset.
.equ  _AFECCOCRV,     0X006C      @ Channel Offset Compensation Register offset.
.equ  _AFECTEMPMRV,   0X0070      @ Temperature Sensor Mode Register offset.
.equ  _AFECTEMPCWRV,  0X0074      @ Temperature Compare Window Register offset.
.equ  _AFECACRV,      0X0094      @ Analog Control Register offset.
.equ  _AFECSHMRV,     0X00A0      @ Sample & Hold Mode Register offset.
.equ  _AFECCOSRV,     0X00D0      @ Correction Select Register offset.
.equ  _AFECCVRV,      0X00D4      @ Correction Value Register offset.
.equ  _AFECCECRV,     0X00D8      @ Channel Error Correction Register offset.
.equ  _AFECWPMRV,     0X00E4      @ Write Protection Mode Register offset.
.equ  _AFECWPSRV,     0X00E8      @ Write Protection Status Register offset.
@-----------------------------------------------------------------------------
@ AFEC Register definitions.
.EQU  _AFEC,          0X4003C000              @ AFEC register group base address.
.equ  _AFECCR,        (_AFEC + _AFECCRV)      @ Control Register.
.equ  _AFECMR,        (_AFEC + _AFECMRV)      @ Mode Register.
.equ  _AFECEMR,       (_AFEC + _AFECEMRV)     @ Extended Mode Regiter.
.equ  _AFECSEQ1R,     (_AFEC + _AFECSEQ1RV)   @ Channel Sequence 1 Register.
.equ  _AFECSEQ2R,     (_AFEC + _AFECSEQ2RV)   @ Channel Sequence 2 Register.
.equ  _AFECCHER,      (_AFEC + _AFECCHERV)    @ Channel Enable Register.
.equ  _AFECCHDR,      (_AFEC + _AFECCHDRV)    @ Channel Disable Register.
.equ  _AFECCHSR,      (_AFEC + _AFECCHSRV)    @ Channel Status Register.
.equ  _AFECLCDR,      (_AFEC + _AFECLCDRV)    @ Last Converted Data Register.
.equ  _AFECIER,       (_AFEC + _AFECIERV)     @ Interrupt Enable Register.
.equ  _AFECIDR,       (_AFEC + _AFECIDRV)     @ Interrupt Disable Register.
.equ  _AFECIMR,       (_AFEC + _AFECIMRV)     @ Interrupt Mask Register.
.equ  _AFECISR,       (_AFEC + _AFECISRV)     @ Interrupt Status Register.
.equ  _AFECOVER,      (_AFEC + _AFECOVERV)    @ Overrun Status Register.
.equ  _AFECCWR,       (_AFEC + _AFECCWRV)     @ Compare Window Register.
.equ  _AFECCGR,       (_AFEC + _AFECCGRV)     @ Channel Gain Register.
.equ  _AFECDIFFR,     (_AFEC + _AFECDIFFRV)   @ Channel Differential Register.
.equ  _AFECCSELR,     (_AFEC + _AFECCSELRV)   @ Channel Selection Register.
.equ  _AFECCDR,       (_AFEC + _AFECCDRV)     @ Channel Data Register.
.equ  _AFECCOCR,      (_AFEC + _AFECCOCRV)    @ Channel Offset Compensation Register.
.equ  _AFECTEMPMR,    (_AFEC + _AFECTEMPMRV)  @ Temperature Sensor Mode Register.
.equ  _AFECTEMPCWR,   (_AFEC + _AFECTEMPCWRV) @ Temperature Compare Window Register.
.equ  _AFECACR,       (_AFEC + _AFECACRV)     @ Analog Control Register.
.equ  _AFECSHMR,      (_AFEC + _AFECSHMRV)    @ Sample & Hold Mode Register.
.equ  _AFECCOSR,      (_AFEC + _AFECCOSRV)    @ Correction Select Register.
.equ  _AFECCVR,       (_AFEC + _AFECCVRV)     @ Correction Value Register.
.equ  _AFECCECR,      (_AFEC + _AFECCECRV)    @ Channel Error Correction Register.
.equ  _AFECWPMR,      (_AFEC + _AFECWPMRV)    @ Write Protection Mode Register.
.equ  _AFECWPSR,      (_AFEC + _AFECWPSRV)    @ Write Protection Status Register.
@-----------------------------------------------------------------------------
@ AFEC Register bit-field definitions
@ AFEC_CR Control Register.
.equ  _AFESWRST,      (1 << 0)      @ Software Reset.
.equ  _AFESTART,      (1 << 1)      @ Start Conversion.
@ AFEC_MR Mode Register.
.equ  _AFETRGEN,      (1 << 0)      @ Trigger Enable.
.equ  _AFETRGSELMSK,  (0X07 << 1)   @ Trigger Selection bit-mask.
.equ  _AFETRIG0,      (0 << 1)      @ External : ADCTRG.
.equ  _AFETRIG1,      (1 << 1)      @ TIOA Output of Timer Counter Channel 0.
.equ  _AFETRIG2,      (2 << 1)      @ TIOA Output of Timer Counter Channel 1.
.equ  _AFETRIG3,      (3 << 1)      @ TIOA Output of Timer Counter Channel 2.
.equ  _AFETRIG4,      (4 << 1)      @ PWM0 Event Line 0.
.equ  _AFETRIG5,      (5 << 1)      @ PWM0 Event Line 1.
.equ  _AFETRIG6,      (6 << 1)      @ Analog Comparator.
.equ  _AFEBITS12,     (0 << 4)      @ 12-Bit Resolution.
.equ  _AFEBITS10,     (1 << 4)      @ 10-Bit Resolution.
.equ  _AFESLEEP,      (1 << 5)      @ Sleep Mode.
.equ  _AFEFWUP,       (1 << 6)      @ Fast Wake Up Mode.
.equ  _AFEFREERUN,    (1 << 7)      @ Free Run Mode.
.equ  _AFEPRESCALPOS, 8             @ Prescaler bit-field position.
.equ  _AFEPRESCALMSK, (0XFF << 8)   @ Prescaler Rate Selection Mask: MCLK/((PRESCAL+1)*2).
.equ  _AFESUT0,       (0 << 16)     @ Start Up Time 0 periods of ADCClock.
.equ  _AFESUT8,       (1 << 16)     @ Start Up Time 8 periods of ADCClock.
.equ  _AFESUT16,      (2 << 16)     @ Start Up Time 16 periods of ADCClock.
.equ  _AFESUT24,      (3 << 16)     @ Start Up Time 24 periods of ADCClock.
.equ  _AFESUT64,      (4 << 16)     @ Start Up Time 64 periods of ADCClock.
.equ  _AFESUT80,      (5 << 16)     @ Start Up Time 80 periods of ADCClock.
.equ  _AFESUT96,      (6 << 16)     @ Start Up Time 96 periods of ADCClock.
.equ  _AFESUT112,     (7 << 16)     @ Start Up Time 112 periods of ADCClock.
.equ  _AFESUT512,     (8 << 16)     @ Start Up Time 512 periods of ADCClock.
.equ  _AFESUT576,     (9 << 16)     @ Start Up Time 576 periods of ADCClock.
.equ  _AFESUT640,     (10 << 16)    @ Start Up Time 640 periods of ADCClock.
.equ  _AFESUT704,     (11 << 16)    @ Start Up Time 740 periods of ADCClock.
.equ  _AFESUT768,     (12 << 16)    @ Start Up Time 768 periods of ADCClock.
.equ  _AFESUT832,     (13 << 16)    @ Start Up Time 832 periods of ADCClock.
.equ  _AFESUT896,     (14 << 16)    @ Start Up Time 896 periods of ADCClock.
.equ  _AFESUT960,     (15 << 16)    @ Start Up Time 960 periods of ADCClock.
.equ  _AFEONE,        (1 << 23)     @ Always set to one.
.equ  _AFETRKTIME,    (15 << 24)    @ Tracking Time.
.equ  _AFEUSEQ,       (1 << 31)     @ User Sequence Mode.
@ AFEC_EMR Extended Mode Register.
.equ  _AFECMPMODEMSK, (3 << 0)      @ Comparison Mode bit-mask.
.equ  _AFECMPMODELOW, (0 << 0)      @ Converted data is lower then low threshold.
.equ  _AFECMPMODEHI,  (1 << 0)      @ Converted data is higher then high threshold.
.equ  _AFECMPMODEIN,  (2 << 0)      @ Converted data is in the comparison window.
.equ  _AFECMPMODEOUT, (3 << 0)      @ Converted data is outside comparison window.
.equ  _AFECMPSELPOS,  3             @ Comparison Selected Channel bits position.
.equ  _AFECMPSELMSK,  (0X1F << 3)   @ Comparison Selected Channel bit-mask.
.equ  _AFECMPALL,     (1 << 9)      @ Compare All Channels.
.equ  _AFECMPFLTRPOS, 12            @ Compare Event Filtering bits position.
.equ  _AFECMPFLTRMSK, (3 << 12)     @ Compare Event Filtering bit-mask.
.equ  _AFERESPOS,     16            @ Resolution bits position.
.equ  _AFERESMSK,     (7 << 16)     @ Resolution bit-mask.
.equ  _AFERES12,      (0 << 16)     @ 12-bit resolution (no-averaging).
.equ  _AFERESOSR4,    (2 << 16)     @ 13-bit resolution smp-rate/4 (averaging).
.equ  _AFERESOSR16,   (3 << 16)     @ 14-bit resolution smp-rate/16 (ageraging).
.equ  _AFERESOSR64,   (4 << 16)     @ 15-bit resolution smp-rate/64 (averaging).
.equ  _AFERESOSR256,  (5 << 16)     @ 16-bit resolution smp-rate/256 (averaging).
.equ  _AFETAG,        (1 << 24)     @ TAG of the AFEC_LDCR.
.equ  _AFESTM,        (1 << 25)     @ Single Trigger Mode.
.equ  _AFESIGNMODPOS, 28            @ Sign Mode bits position.
.equ  _AFESIGNMODMSK, (3 << 28)     @ Sign Mode bit-mask.
.equ  _AFESEUDFS,     (0 << 28)     @ Single-Ended unsigned / Differential signed conversions.
.equ  _AFESESDFU,     (1 << 28)     @ Single-Ended signed / Differential unsigned conversions.
.equ  _AFEUNSIGNED,   (2 << 28)     @ All channels unsigned conversions.
.equ  _AFESIGNED,     (3 << 28)     @ All channels signed conversions.
@ AFEC_IER Interrupt Enable Register.
.equ  _AFEDRDY,       (1 << 24)     @ Data Ready.
.equ  _AFEGOVRE,      (1 << 25)     @ General Overrun Error.
.equ  _AFECOMPE,      (1 << 26)     @ Comparaison Event.
.equ  _AFETMPCHG,     (1 << 30)     @ Temperature Change.
@ AFEC Analog Channel bit-fields.
.equ  _AFECH0,        (1 << 0)      @ Analog Channel 0.
.equ  _AFECH1,        (1 << 1)      @ Analog Channel 1.
.equ  _AFECH2,        (1 << 2)      @ Analog Channel 2.
.equ  _AFECH3,        (1 << 3)      @ Analog Channel 3.
.equ  _AFECH4,        (1 << 4)      @ Analog Channel 4.
.equ  _AFECH5,        (1 << 5)      @ Analog Channel 5.
.equ  _AFECH6,        (1 << 6)      @ Analog Channel 6.
.equ  _AFECH7,        (1 << 7)      @ Analog Channel 7.
.equ  _AFECH8,        (1 << 8)      @ Analog Channel 8.
.equ  _AFECH9,        (1 << 9)      @ Analog Channel 9.
.equ  _AFECH10,       (1 << 10)     @ Analog Channel 10.
.equ  _AFECH11,       (1 << 11)     @ Analog Channel 11.
@ ADC Analog Control Register.
.equ  _AFEPGA0EN,     (1 << 2)      @ Programmable Gain Amplifier 0 Enable.
.equ  _AFEPGA1EN,     (1 << 3)      @ Programmagle Gain Amplifier 1 Enable.
.equ  _AFEIBCTL0,     (0 << 8)      @ AFE Bias Current COntrol.
.equ  _AFEIBCTL1,     (1 << 8)      @ AFE Bias Current COntrol.
.equ  _AFEIBCTL2,     (2 << 8)      @ AFE Bias Current COntrol.
.equ  _AFEIBCTL3,     (3 << 8)      @ AFE Bias Current COntrol.
@ AFEC_CGR Channel Gain Register.
.equ  _AFEGAIN0,      0             @ Channel 0 bits position.
.equ  _AFEGAIN1,      2             @ Channel 1 bits position.
.equ  _AFEGAIN2,      4             @ Channel 2 bits position.
.equ  _AFEGAIN3,      6             @ Channel 3 bits position.
.equ  _AFEGAIN4,      8             @ Channel 4 bits position.
.equ  _AFEGAIN5,      10            @ Channel 5 bits position.
.equ  _AFEGAIN6,      12            @ Channel 6 bits position.
.equ  _AFEGAIN7,      14            @ Channel 7 bits position.
.equ  _AFEGAIN8,      16            @ Channel 8 bits position.
.equ  _AFEGAIN9,      18            @ Channel 9 bits position.
.equ  _AFEGAIN10,     20            @ Channel 10 bits position.
.equ  _AFEGAIN11,     22            @ Channel 11 bits position.
.equ  _AFEGAINMSK,    3             @ Channel gain bit-mask (shift by channel pos).
.equ  _AFEGAIN1,      0             @ Gain 1X.
.equ  _AGEGAIN2,      1             @ Gain 2X.
.equ  _AFEGAIN4,      2             @ Gain 4X.
@ AFEC_WPMR Write Protection Mode Register.
.equ  _AFEWPKEY,      0X41444300    @ Write Protect Key (PASSWD).
.equ  _AFEWPEN,       (1 << 0)      @ Write Protect Enable.
@-----------------------------------------------------------------------------
@ GMAC Register offsets from group base address.
.equ  _GMACNCRV,      0X0000      @ Network Control Register offset.
.equ  _GMACNCFGRV,    0X0004      @ Network Configuration Register offset.
.equ  _GMACNSRV,      0X0008      @ Network Status Register offset.
.equ  _GMACURV,       0X000C      @ User Register offset.
.equ  _GMACDCFGRV,    0X0010      @ DMA Configuration register offset.
.equ  _GMACTSRV,      0X0014      @ Transmit Statu Register offset.
.equ  _GMACRBQBV,     0X0018      @ Receive Buffr QUEUE Base Address Register offset.
.equ  _GMACTBQBV,     0X001C      @ Transmit Buffer QUEUE Base Address Register offset.
.equ  _GMACRSRV,      0X0020      @ Receive Status Register offset.
.equ  _GMACISRV,      0X0024      @ Interrupt Status Register offset.
.equ  _GMACIERV,      0X0028      @ Interrupt Enable Register offset.
.equ  _GMACIDRV,      0X002C      @ Interrupt Disable Register offset.
.equ  _GMACIMRV,      0X0030      @ Interrupt Mask Register offset.
.equ  _GMACMANV,      0X0034      @ PHY Maintenance Register offset.
.equ  _GMACRPQV,      0X0038      @ Received Pause Quantum Register  offset.
.equ  _GMACTPQV,      0X003C      @ Transmit Pause Quantum Register offset.
.equ  _GMACTPSFV,     0X0040      @ TX Partial Store and Forward Register offset.
.equ  _GMACRPSFV,     0X0044      @ RX Partial Store and Forward Register offset.
.equ  _GMACRJFMLV,    0X0048      @ RX Jumbo Frame Max Length Register offset.
.equ  _GMACHRBV,      0X0080      @ Hash Register Bottom offset.
.equ  _GMACHRTV,      0X0084      @ Hash Register Top offset.
.equ  _GMACSAB1V,     0X0088      @ Specific Address 1 Bottom Register offset.
.equ  _GMACSAT1V,     0X008C      @ Specific Address 1 Top Register offset.
.equ  _GMACSAB2V,     0X0090      @ Specific Address 2 Bottom Register offset.
.equ  _GMACSAT2V,     0X0094      @ Specific Address 2 Top Register offset.
.equ  _GMACSAB3V,     0X0098      @ Specific Address 3 Bottom Register offset.
.equ  _GMACSAT3V,     0X009C      @ Specific Address 3 Top Register offset.
.equ  _GMACSAB4V,     0X00A0      @ Specific Address 4 Bottom Register offset.
.equ  _GMACSAT4V,     0X00A4      @ Specific Address 4 Top Register offset.
.equ  _GMACTIDM1V,    0X00A8      @ Type ID Match 1 Register offset.
.equ  _GMACTIDM2V,    0X00AC      @ Type ID Match 2 Register offset.
.equ  _GMACTIDM3V,    0X00B0      @ Type ID Match 3 Register offset.
.equ  _GMACTIDM4V,    0X00B4      @ Type ID Match 4 Register offset.
.equ  _GMACWOLV,      0X00B8      @ Wake On LAN Register offset.
.equ  _GMACIPGSV,     0X00BC      @ IPG Strech Register offset.
.equ  _GMACSVLANV,    0X00C0      @ Stacked VLAN Register offset.
.equ  _GMACTPFCPV,    0X00C4      @ Transmit PFC Pause Register offset.
.equ  _GMACSAMB1V,    0X00C8      @ Specific Addrecc 1 Mask Bottom Registr offset.
.equ  _GMACSAMT1V,    0X00CC      @ Specific Address 1 Mask Top Register offset.
.equ  _GMACNSCV,      0X00DC      @ 1588 Timer Nanosecond Comparison Register offset.
.equ  _GMACSCLV,      0X00E0      @ 1588 Timer Second Comparison Register offset.
.equ  _GMACSCHV,      0X00E4      @ 1588 Timer Second Comparison Register offset.
.equ  _GMACEFTSHV,    0X00E8      @ PTP Event Frame Transmitted Seconds High Registr offset.
.equ  _GMACEFRSHV,    0X00EC      @ PTP Event Frame Received Seconds High Register offset.
.equ  _GMACPEFTSHV,   0X00F0      @ PTP Peer Event Frame Transmitted Seconds High Register offset.
.equ  _GMACPEFRSHV,   0X00F4      @ PTP Peer Event Frame Received Seconds High Register offset.
.equ  _GMACOTLOV,     0X0100      @ Octets Transmitted Low Register offset.
.equ  _GMACOTHIV,     0X0104      @ Octets Transmitted High Register offset.
.equ  _GMACFTV,       0X0108      @ Frames Transmitted Register offset.
.equ  _GMACBCFTV,     0X010C      @ Broadcast Frames Transmitted Register offset.
.equ  _GMACMFTV,      0X0110      @ Multicast Frames Transmitted Register offset.
.equ  _GMACPFTV,      0X0114      @ Pause Frames Transmitted Register offset.
.equ  _GMACBFT64V,    0X0118      @ 64 Byte Frames Transmitted Register offset.
.equ  _GMACTBFT127V,  0X011C      @ 65-127 Byte Frames Transmitted Register offset.
.equ  _GMACTBFT255V,  0X0120      @ 128-255 Byte Frames Transmitted Register offset.
.equ  _GMACTBFT511V,  0X0124      @ 256-511 Byte Frames Transmitted Register offset.
.equ  _GMACTBFT1023V, 0X0128      @ 512-1023 Byte Frames Transmitted Register offset.
.equ  _GMACTBFT1518V, 0X012C      @ 1024-1518 Byte Frames Transmitted Register offset.
.equ  _GMACGTBFT1518V,0X0130      @ Greater Than 1518 Byte Frames Transmitted Register offset.
.equ  _GMACTURV,      0X0134      @ Transmit Underruns Register offset.
.equ  _GMACSCFV,      0X0138      @ Single Collision Frames Register offset.
.equ  _GMACMCFV,      0X013C      @ Multiple Collision Frames Register offset.
.equ  _GMACECV,       0X0140      @ Excessive Collisions Register offset.
.equ  _GMACLCV,       0X0144      @ Late Collisions Register offset.
.equ  _GMACDTFV,      0X0148      @ Deferred Transmission Frames Register offset.
.equ  _GMACCSEV,      0X014C      @ Carrier Sense Errors Register offset.
.equ  _GMACORLOV,     0X0150      @ Octets Received Low Register offset.
.equ  _GMACORHIV,     0X0154      @ Octets Received High Register offset.
.equ  _GMACFRV,       0X0158      @ Frames Received Register offset.
.equ  _GMACBCFRV,     0X015C      @ Broadcast Frames Received Register offset.
.equ  _GMACMFRV,      0X0160      @ Multicast Frames Received Register offset.
.equ  _GMACPFRV,      0X0164      @ Pause Frames Received Register offset.
.equ  _GMACBFT64V,    0X0168      @ 64 Byte Frames Received Register offset.
.equ  _GMACTBFR127V,  0X016C      @ 65-127 Byte Frames Received Register offset.
.equ  _GMACTBFR255V,  0X0170      @ 128-255 Byte Frames Received Register offset.
.equ  _GMACTBFR511V,  0X0174      @ 256-511 Byte Frames Received Register offset.
.equ  _GMACTBFR1023V, 0X0178      @ 512-1023 Byte Frames Received Register offset.
.equ  _GMACTBFR1518V, 0X017C      @ 1024-1518 Byte Frames Received Register offset.
.equ  _GMACTMXBFRV,   0X0180      @ 1519 to Maximum Byte Frames Received Register offset.
.equ  _GMACUFRV,      0X0184      @ Undersize Frames Received Register offset.
.equ  _GMACOFRV,      0X0188      @ Oversize Frames Received Register offset.
.equ  _GMACJRV,       0X018C      @ Jabbers Received Register offset.
.equ  _GMACFCSEV,     0X0190      @ Frame Check Sequence Errors Register offset.
.equ  _GMACLFFEV,     0X0194      @ Length Field Frame Errors offset.
.equ  _GMACRSEV,      0X0198      @ Receive Symbol Errors Register offset.
.equ  _GMACAEV,       0X019C      @ Alignment Errors Register offset.
.equ  _GMACRREV,      0X01A0      @ Receive Resource Errors Register offset.
.equ  _GMACROEV,      0X01A4      @ Receive Overrun Errors Register offset.
.equ  _GMACIHCEV,     0X01A8      @ IP Header Checksum Errors Register offset.
.equ  _GMACTCEV,      0X01AC      @ TCP Checksum Errors Register offset.
.equ  _GMACUCEV,      0X01B0      @ UDP Checksum Errors Register offset.
.equ  _GMACTISUBNV,   0X01BC      @ 1588 Timer Increment Sub-nanoseconds Register offset.
.equ  _GMACTSHV,      0X01C0      @ 1588 Timer Seconds High Register offset.
.equ  _GMACTSLV,      0X01D0      @ 1588 Timer Seconds Low Register offset.
.equ  _GMACTNV,       0X01D4      @ 1588 Timer Nanoseconds Register offset.
.equ  _GMACTAV,       0X01D8      @ 1588 Timer Adjust Register offset.
.equ  _GMACTIV,       0X01DC      @ 1588 Timer Increment Regiter offset.
.equ  _GMACEFTSLV,    0X01E0      @ PTP Event Frame Transmitte Seconds Low Register offset.
.equ  _GMACEFTNV,     0X01E4      @ PTP Event Frame Transmitted Nanoseconds Register offset.
.equ  _GMACEFRSLV,    0X01E8      @ PTP Event Frame Received Seconds Low Register offset.
.equ  _GMACEFRNV,     0X01EC      @ PTP Event Frame Received Nanoseconds Register offset.
.equ  _GMACPEFTSLV,   0X01F0      @ PTP Peer Event Frame Transmitted Seconds Low Register offset.
.equ  _GMACPEFTNV,    0X01F4      @ PTP Peer Event Frame Transmitted Nanoseconds Register offset.
.equ  _GMACPEFRSLV,   0X01F8      @ PTP Peer Event Frame Received Seconds Low offset.
.equ  _GMACPEFRNV,    0X01FC      @ PTP Peer Event Frame Received Nanoseconds Register.
.ifdef _REVISION_B_
.equ  _GMACISRPQV,    0X0400      @ Interrupt Status Register Priority Queue Register offset.
.equ  _GMACTBQBAPQV,  0X0440      @ Transmit Buffer Queue Base Address Register offset.
.equ  _GMACRBQBAPQV,  0X0480      @ Receive Buffer QUEUE Base Address Register offset.
.equ  _GMACRBSRPQV,   0X04A0      @ Receive Buffer Size Register offset.
.else
.equ  _GMACISRPQV,    0X03FC      @ Interrupt Status Register Priority Queue Register offset.
.equ  _GMACTBQBAPQV,  0X043C      @ Transmit Buffer Queue Base Address Register offset.
.equ  _GMACRBQBAPQV,  0X047C      @ Receive Buffer QUEUE Base Address Register offset.
.equ  _GMACRBSRPQV,   0X049C      @ Receive Buffer Size Register offset.
.endif
.equ  _GMACCBSCRV,    0X04BC      @ Credit-Based Shaping Control Register offset.
.equ  _GMACCBSISQAV,  0X04C0      @ Credit-Based Shaping IdleSlope Register for Queue A offset.
.equ  _GMACCBSISQBV,  0X04C4      @ Credit-Based Shaping IdleSlope Register for Queue B offset.
.equ  _GMACST1RPQV,   0X0500      @ Screening Type 1 Register Priority Queue offset.
.equ  _GMACST2RPQV,   0X0540      @ Screening Type 2 Register Priority Queue offset.
.ifdef _REVISION_B_
.equ  _GMACIERPQV,    0X0600      @ Interrupt Enable Regiter Priority Queue offset.
.equ  _GMACIDRPQV,    0X0620      @ Interrupt Disable Regiter Priority Queue offset.
.equ  _GMACIMRPQV,    0X0640      @ Interrupt Mask Regiter Priority Queue offset.
.else
.equ  _GMACIERPQV,    0X05FC      @ Interrupt Enable Regiter Priority Queue offset.
.equ  _GMACIDRPQV,    0X061C      @ Interrupt Disable Regiter Priority Queue offset.
.equ  _GMACIMRPQV,    0X063C      @ Interrupt Mask Regiter Priority Queue offset.
.endif
.equ  _GMACSTR2ERV,   0X06E0      @ Screening Type 2 Ethertype Register offset.
.equ  _GMACST2CW0V,   0X0700      @ Screening Type 2 Compare Word 0 Regiter offset.
.equ  _GMACST2CW1V,   0X0704      @ Screening Type 2 Compare Word 1 Regiter offset.
@-----------------------------------------------------------------------------
@ GMAC Register definitions.
.equ  _GMAC,          0X40050000                @ GMAC Register group base address.
.equ  _GMACNCR,       (_GMAC + _GMACNCRV)       @ Network Control Register.
.equ  _GMACNCFGR,     (_GMAC + _GMACNCFGRV)     @ Network Configuration Register.
.equ  _GMACNSR,       (_GMAC + _GMACNSRV)       @ Network Status Register.
.equ  _GMACUR,        (_GMAC + _GMACURV)        @ User Register.
.equ  _GMACDCFGR,     (_GMAC + _GMACDCFGRV)     @ DMA Configuration register.
.equ  _GMACTSR,       (_GMAC + _GMACTSRV)       @ Transmit Statu Register.
.equ  _GMACRBQB,      (_GMAC + _GMACRBQBV)      @ Receive Buffr QUEUE Base Address Register.
.equ  _GMACTBQB,      (_GMAC + _GMACTBQBV)      @ Transmit Buffer QUEUE Base Address Register.
.equ  _GMACRSR,       (_GMAC + _GMACRSRV)       @ Receive Status Register.
.equ  _GMACISR,       (_GMAC + _GMACISRV)       @ Interrupt Status Register.
.equ  _GMACIER,       (_GMAC + _GMACIERV)       @ Interrupt Enable Register.
.equ  _GMACIDR,       (_GMAC + _GMACIDRV)       @ Interrupt Disable Register.
.equ  _GMACIMR,       (_GMAC + _GMACIMRV)       @ Interrupt Mask Register.
.equ  _GMACMAN,       (_GMAC + _GMACMANV)       @ PHY Maintenance Register.
.equ  _GMACRPQ,       (_GMAC + _GMACRPQV)       @ Received Pause Quantum Register.
.equ  _GMACTPQ,       (_GMAC + _GMACTPQV)       @ Transmit Pause Quantum Register.
.equ  _GMACTPSF,      (_GMAC + _GMACTPSFV)      @ TX Partial Store and Forward Register.
.equ  _GMACRPSF,      (_GMAC + _GMACRPSFV)      @ RX Partial Store and Forward Register.
.equ  _GMACRJFML,     (_GMAC + _GMACRJFMLV)     @ RX Jumbo Frame Max Length Register.
.equ  _GMACHRB,       (_GMAC + _GMACHRBV)       @ Hash Register Bottom Register.
.equ  _GMACHRT,       (_GMAC + _GMACHRTV)       @ Hash Register Top Register.
.equ  _GMACSAB1,      (_GMAC + _GMACSAB1V)      @ Specific Address 1 Bottom Register.
.equ  _GMACSAT1,      (_GMAC + _GMACSAT1V)      @ Specific Address 1 Top Register.
.equ  _GMACSAB2,      (_GMAC + _GMACSAB2V)      @ Specific Address 2 Bottom Register.
.equ  _GMACSAT2,      (_GMAC + _GMACSAT2V)      @ Specific Address 2 Top Register.
.equ  _GMACSAB3,      (_GMAC + _GMACSAB3V)      @ Specific Address 3 Bottom Register.
.equ  _GMACSAT3,      (_GMAC + _GMACSAT3V)      @ Specific Address 3 Top Register.
.equ  _GMACSAB4,      (_GMAC + _GMACSAB4V)      @ Specific Address 4 Bottom Register.
.equ  _GMACSAT4,      (_GMAC + _GMACSAT4V)      @ Specific Address 4 Top Register.
.equ  _GMACTIDM1,     (_GMAC + _GMACTIDM1V)     @ Type ID Match 1 Register.
.equ  _GMACTIDM2,     (_GMAC + _GMACTIDM2V)     @ Type ID Match 2 Register.
.equ  _GMACTIDM3,     (_GMAC + _GMACTIDM3V)     @ Type ID Match 3 Register.
.equ  _GMACTIDM4,     (_GMAC + _GMACTIDM4V)     @ Type ID Match 4 Register.
.equ  _GMACWOL,       (_GMAC + _GMACWOLV)       @ Wake On LAN Register.
.equ  _GMACIPGS,      (_GMAC + _GMACIPGSV)      @ IPG Strech Register.
.equ  _GMACSVLAN,     (_GMAC + _GMACSVLANV)     @ Stacked VLAN Register.
.equ  _GMACTPFCP,     (_GMAC + _GMACTPFCPV)     @ Transmit PFC Pause Register.
.equ  _GMACSAMB1,     (_GMAC + _GMACSAMB1V)     @ Specific Addrecc 1 Mask Bottom Register.
.equ  _GMACSAMT1,     (_GMAC + _GMACSAMT1V)     @ Specific Address 1 Mask Top Register.
.equ  _GMACNSC,       (_GMAC + _GMACNSCV)       @ 1588 Timer Nanosecond Comparison Register.
.equ  _GMACSCL,       (_GMAC + _GMACSCLV)       @ 1588 Timer Second Comparison Register.
.equ  _GMACSCH,       (_GMAC + _GMACSCHV)       @ 1588 Timer Second Comparison Register.
.equ  _GMACEFTSH,     (_GMAC + _GMACEFTSHV)     @ PTP Event Frame Transmitted Seconds High Register.
.equ  _GMACEFRSH,     (_GMAC + _GMACEFRSHV)     @ PTP Event Frame Received Seconds High Register.
.equ  _GMACPEFTSH,    (_GMAC + _GMACPEFTSHV)    @ PTP Peer Event Frame Transmitted Seconds High Register.
.equ  _GMACPEFRSH,    (_GMAC + _GMACPEFRSHV)    @ PTP Peer Event Frame Received Seconds High Registr.
.equ  _GMACOTLO,      (_GMAC + _GMACOTLOV)      @ Octets Transmitted Low Register.
.equ  _GMACOTHI,      (_GMAC + _GMACOTHIV)      @ Octets Transmitted High Register.
.equ  _GMACFT,        (_GMAC + _GMACFTV)        @ Frames Transmitted Register.
.equ  _GMACBCFT,      (_GMAC + _GMACBCFTV)      @ Broadcast Frames Transmitted Register.
.equ  _GMACMFT,       (_GMAC + _GMACMFTV)       @ Multicast Frames Transmitted Register.
.equ  _GMACPFT,       (_GMAC + _GMACPFTV)       @ Pause Frames Transmitted Register.
.equ  _GMACBFT64,     (_GMAC + _GMACBFT64V)     @ 64 Byte Frames Transmitted Register.
.equ  _GMACTBFT127,   (_GMAC + _GMACTBFT127V)   @ 65-127 Byte Frames Transmitted Register.
.equ  _GMACTBFT255,   (_GMAC + _GMACTBFT255V)   @ 128-255 Byte Frames Transmitted Register.
.equ  _GMACTBFT511,   (_GMAC + _GMACTBFT511V)   @ 256-511 Byte Frames Transmitted Register.
.equ  _GMACTBFT1023,  (_GMAC + _GMACTBFT1023V)  @ 512-1023 Byte Frames Transmitted Register.
.equ  _GMACTBFT1518,  (_GMAC + _GMACTBFT1518V)  @ 1024-1518 Byte Frames Transmitted Register.
.equ  _GMACGTBFT1518, (_GMAC + _GMACGTBFT1518V) @ Greater Than 1518 Byte Frames Transmitted Register.
.equ  _GMACTUR,       (_GMAC + _GMACTURV)       @ Transmit Underruns Register.
.equ  _GMACSCF,       (_GMAC + _GMACSCFV)       @ Single Collision Frames Register.
.equ  _GMACMCF,       (_GMAC + _GMACMCFV)       @ Multiple Collision Frames Register.
.equ  _GMACEC,        (_GMAC + _GMACECV)        @ Excessive Collisions Register.
.equ  _GMACLC,        (_GMAC + _GMACLCV)        @ Late Collisions Register.
.equ  _GMACDTF,       (_GMAC + _GMACDTFV)       @ Deferred Transmission Frames Register.
.equ  _GMACCSE,       (_GMAC + _GMACCSEV)       @ Carrier Sense Errors Register.
.equ  _GMACORLO,      (_GMAC + _GMACORLOV)      @ Octets Received Low Register.
.equ  _GMACORHI,      (_GMAC + _GMACORHIV)      @ Octets Received High Registerr.
.equ  _GMACFR,        (_GMAC + _GMACFRV)        @ Frames Received Register.
.equ  _GMACBCFR,      (_GMAC + _GMACBCFRV)      @ Broadcast Frames Received Register.
.equ  _GMACMFR,       (_GMAC + _GMACMFRV)       @ Multicast Frames Received Register.
.equ  _GMACPFR,       (_GMAC + _GMACPFRV)       @ Pause Frames Received Register.
.equ  _GMACBFT64,     (_GMAC + _GMACBFT64V)     @ 64 Byte Frames Received Register.
.equ  _GMACTBFR127,   (_GMAC + _GMACTBFR127V)   @ 65-127 Byte Frames Received Register.
.equ  _GMACTBFR255,   (_GMAC + _GMACTBFR255V)   @ 128-255 Byte Frames Received Register.
.equ  _GMACTBFR511,   (_GMAC + _GMACTBFR511V)   @ 256-511 Byte Frames Received Register.
.equ  _GMACTBFR1023,  (_GMAC + _GMACTBFR1023V)  @ 512-1023 Byte Frames Received Register.
.equ  _GMACTBFR1518,  (_GMAC + _GMACTBFR1518V)  @ 1024-1518 Byte Frames Received Register.
.equ  _GMACTMXBFR,    (_GMAC + _GMACTMXBFRV)    @ 1519 to Maximum Byte Frames Received Register.
.equ  _GMACUFR,       (_GMAC + _GMACUFRV)       @ Undersize Frames Received Registr.
.equ  _GMACOFR,       (_GMAC + _GMACOFRV)       @ Oversize Frames Received Register.
.equ  _GMACJR,        (_GMAC + _GMACJRV)        @ Jabbers Received Register.
.equ  _GMACFCSE,      (_GMAC + _GMACFCSEV)      @ Frame Check Sequence Errors Register.
.equ  _GMACLFFE,      (_GMAC + _GMACLFFEV)      @ Length Field Frame Errors Register.
.equ  _GMACRSE,       (_GMAC + _GMACRSEV)       @ Receive Symbol Errors Register.
.equ  _GMACAE,        (_GMAC + _GMACAEV)        @ Alignment Errors Register.
.equ  _GMACRRE,       (_GMAC + _GMACRREV)       @ Receive Resource Errors Register.
.equ  _GMACROE,       (_GMAC + _GMACROEV)       @ Receive Overrun Errors Register.
.equ  _GMACIHCE,      (_GMAC + _GMACIHCEV)      @ IP Header Checksum Errors Register.
.equ  _GMACTCE,       (_GMAC + _GMACTCEV)       @ TCP Checksum Errors Register.
.equ  _GMACUCE,       (_GMAC + _GMACUCEV)       @ UDP Checksum Errors Register.
.equ  _GMACTISUBN,    (_GMAC + _GMACTISUBNV)    @ 1588 Timer Increment Sub-nanoseconds Register.
.equ  _GMACTSH,       (_GMAC + _GMACTSHV)       @ 1588 Timer Seconds High Regiter.
.equ  _GMACTSL,       (_GMAC + _GMACTSLV)       @ 1588 Timer Seconds Low Register.
.equ  _GMACTN,        (_GMAC + _GMACTNV)        @ 1588 Timer Nanoseconds Register.
.equ  _GMACTA,        (_GMAC + _GMACTAV)        @ 1588 Timer Adjust Register.
.equ  _GMACTI,        (_GMAC + _GMACTIV)        @ 1588 Timer Increment Regiter.
.equ  _GMACEFTSL,     (_GMAC + _GMACEFTSLV)     @ PTP Event Frame Transmitte Seconds Low Register.
.equ  _GMACEFTN,      (_GMAC + _GMACEFTNV)      @ PTP Event Frame Transmitted Nanoseconds Register.
.equ  _GMACEFRSL,     (_GMAC + _GMACEFRSLV)     @ PTP Event Frame Received Seconds Low Register.
.equ  _GMACEFRN,      (_GMAC + _GMACEFRNV)      @ PTP Event Frame Received Nanoseconds Register.
.equ  _GMACPEFTSL,    (_GMAC + _GMACPEFTSLV)    @ PTP Peer Event Frame Transmitted Seconds Low Register.
.equ  _GMACPEFTN,     (_GMAC + _GMACPEFTNV)     @ PTP Peer Event Frame Transmitted Nanoseconds Register.
.equ  _GMACPEFRSL,    (_GMAC + _GMACPEFRSLV)    @ PTP Peer Event Frame Received Seconds Low.
.equ  _GMACPEFRN,     (_GMAC + _GMACPEFRNV)     @ PTP Peer Event Frame Received Nanoseconds Register.
.equ  _GMACISRPQ0,    (_GMAC + _GMACISRPQV + (0 * 4))   @ Interrupt Status Register Priority Queue 1 Register.
.equ  _GMACISRPQ1,    (_GMAC + _GMACISRPQV + (1 * 4))   @ Interrupt Status Register Priority Queue 1 Register.
.equ  _GMACISRPQ2,    (_GMAC + _GMACISRPQV + (2 * 4))   @ Interrupt Status Register Priority Queue 2 Register.
.equ  _GMACISRPQ3,    (_GMAC + _GMACISRPQV + (3 * 4))   @ Interrupt Status Register Priority Queue 2 Register.
.equ  _GMACISRPQ4,    (_GMAC + _GMACISRPQV + (4 * 4))   @ Interrupt Status Register Priority Queue 2 Register.
.equ  _GMACISRPQ5,    (_GMAC + _GMACISRPQV + (5 * 4))   @ Interrupt Status Register Priority Queue 2 Register.
.equ  _GMACTBQBAPQ0,  (_GMAC + _GMACTBQBAPQV + (0 * 4)) @ Transmit Buffer Queue Base Address 1 Register.
.equ  _GMACTBQBAPQ1,  (_GMAC + _GMACTBQBAPQV + (1 * 4)) @ Transmit Buffer Queue Base Address 1 Register.
.equ  _GMACTBQBAPQ2,  (_GMAC + _GMACTBQBAPQV + (2 * 4)) @ Transmit Buffer Queue Base Address 2 Register.
.equ  _GMACTBQBAPQ3,  (_GMAC + _GMACTBQBAPQV + (3 * 4)) @ Transmit Buffer Queue Base Address 2 Register.
.equ  _GMACTBQBAPQ4,  (_GMAC + _GMACTBQBAPQV + (4 * 4)) @ Transmit Buffer Queue Base Address 2 Register.
.equ  _GMACTBQBAPQ5,  (_GMAC + _GMACTBQBAPQV + (5 * 4)) @ Transmit Buffer Queue Base Address 2 Register.
.equ  _GMACRBQBAPQ0,  (_GMAC + _GMACRBQBAPQV + (0 * 4)) @ Receive Buffer QUEUE Base Address 1 Register.
.equ  _GMACRBQBAPQ1,  (_GMAC + _GMACRBQBAPQV + (1 * 4)) @ Receive Buffer QUEUE Base Address 1 Register.
.equ  _GMACRBQBAPQ2,  (_GMAC + _GMACRBQBAPQV + (2 * 4)) @ Receive Buffer QUEUE Base Address 2 Register.
.equ  _GMACRBQBAPQ3,  (_GMAC + _GMACRBQBAPQV + (3 * 4)) @ Receive Buffer QUEUE Base Address 2 Register.
.equ  _GMACRBQBAPQ4,  (_GMAC + _GMACRBQBAPQV + (4 * 4)) @ Receive Buffer QUEUE Base Address 2 Register.
.equ  _GMACRBQBAPQ5,  (_GMAC + _GMACRBQBAPQV + (5 * 4)) @ Receive Buffer QUEUE Base Address 2 Register.
.equ  _GMACRBSRPQ0,   (_GMAC + _GMACRBSRPQV + (0 * 4))  @ Receive Buffer Size Register.
.equ  _GMACRBSRPQ1,   (_GMAC + _GMACRBSRPQV + (1 * 4))  @ Receive Buffer Size Register.
.equ  _GMACRBSRPQ2,   (_GMAC + _GMACRBSRPQV + (2 * 4))  @ Receive Buffer Size Register.
.equ  _GMACRBSRPQ3,   (_GMAC + _GMACRBSRPQV + (3 * 4))  @ Receive Buffer Size Register.
.equ  _GMACRBSRPQ4,   (_GMAC + _GMACRBSRPQV + (4 * 4))  @ Receive Buffer Size Register.
.equ  _GMACRBSRPQ5,   (_GMAC + _GMACRBSRPQV + (5 * 4))  @ Receive Buffer Size Register.
.equ  _GMACCBSCR,     (_GMAC + _GMACCBSCRV)     @ Credit-Based Shaping Control Register.
.equ  _GMACCBSISQA,   (_GMAC + _GMACCBSISQAV)   @ Credit-Based Shaping IdleSlope Register for Queue A.
.equ  _GMACCBSISQB,   (_GMAC + _GMACCBSISQBV)   @ Credit-Based Shaping IdleSlope Register for Queue B.
.equ  _GMACST1RPQ,    (_GMAC + _GMACST1RPQV)    @ Screening Type 1 Register Priority Queue.
.equ  _GMACST2RPQ,    (_GMAC + _GMACST2RPQV)    @ Screening Type 2 Register Priority Queue.
.equ  _GMACIERPQ1,    (_GMAC + _GMACIERPQV + (1 * 4))   @ Interrupt Enable Regiter Priority Queue.
.equ  _GMACIERPQ2,    (_GMAC + _GMACIERPQV + (2 * 4))   @ Interrupt Enable Regiter Priority Queue.
.equ  _GMACIDRPQ1,    (_GMAC + _GMACIDRPQV + (1 * 4))   @ Interrupt Disable Regiter Priority Queue.
.equ  _GMACIDRPQ2,    (_GMAC + _GMACIDRPQV + (2 * 4))   @ Interrupt Disable Regiter Priority Queue.
.equ  _GMACIMRPQ1,    (_GMAC + _GMACIMRPQV + (1 * 4))   @ Interrupt Mask Regiter Priority Queue.
.equ  _GMACIMRPQ2,    (_GMAC + _GMACIMRPQV + (2 * 4))   @ Interrupt Mask Regiter Priority Queue.
.equ  _GMACSTR2ER,    (_GMAC + _GMACSTR2ERV)    @ Screening Type 2 Ethertype Register.
.equ  _GMACST2CW0,    (_GMAC + _GMACST2CW0V)    @ Screening Type 2 Compare Word 0 Regite.
.equ  _GMACST2CW1,    (_GMAC + _GMACST2CW1V)    @ Screening Type 2 Compare Word 1 Regiter.
@-----------------------------------------------------------------------------
@ Ethernet MAC bit-field definitions.
@ GMAC_NCR Network Control Register.
.equ  _GMACLBL,       (1 << 1)      @ Loop Back Local.
.equ  _GMACRXEN,      (1 << 2)      @ Receive Enable.
.equ  _GMACTXEN,      (1 << 3)      @ Transmit Enable.
.equ  _GMACMPE,       (1 << 4)      @ Management Port Enable.
.equ  _GMACCLRSTAT,   (1 << 5)      @ Clear Statistics Registers.
.equ  _GMACINCSTAT,   (1 << 6)      @ Increment Statistics Registers.
.equ  _GMACWESTAT,    (1 << 7)      @ Write Enable for Statistics Registers.
.equ  _GMACBP,        (1 << 8)      @ Back Pressure.
.equ  _GMACTSTART,    (1 << 9)      @ Start Transmission.
.equ  _GMACTHALT,     (1 << 10)     @ Transmission Halt.
.equ  _GMACTXPF,      (1 << 11)     @ Transmit Pause Frame.
.equ  _GMACTXZQPF,    (1 << 12)     @ Transmit Zero Quantum Pause Frame.
.equ  _GMACSRTSM,     (1 << 15)     @ Store Receive Time Stamp to Memory.
.equ  _GMACENPBPR,    (1 << 16)     @ Enable PFC Priority-based Pause Reception.
.equ  _GMACTXPBPF,    (1 << 17)     @ Transmit PFC Priority-based Pause Frame.
.equ  _GMACFNP,       (1 << 18)     @ Flush Next Packet.
@ GMAC_NCFGR Network Configuration Register.
.equ  _GMACSPD,       (1 << 0)      @ Speed.
.equ  _GMACFD,        (1 << 1)      @ Full Duplex.
.equ  _GMACDNVLAN,    (1 << 2)      @ Discard Non-VLAN Frames.
.equ  _GMACJFRAME,    (1 << 3)      @ Jumbo Frame Size.
.equ  _GMACCAF,       (1 << 4)      @ Copy All Frames.
.equ  _GMACNBC,       (1 << 5)      @ No Broadcast.
.equ  _GMACMTIHEN,    (1 << 6)      @ Multicast Hash Enable.
.equ  _GMACUNIHEN,    (1 << 7)      @ Unicast Hash Enable.
.equ  _GMACMAXFS,     (1 << 8)      @ 1536 Maximum Frame Size.
.equ  _GMACRTY,       (1 << 12)     @ Retry Test.
.equ  _GMACPEN,       (1 << 13)     @ Pause Enable.
.equ  _GMACRXBUFOMSK, (0X03 << 14)  @ Receive Buffer Offset bit-mask.
.equ  _GMACLFERD,     (1 << 16)     @ Length Field Error Frame Discard.
.equ  _GMACRFCS,      (1 << 17)     @ Remove FCS.
.equ  _GMACCLKPOS,    18            @ MDC Clock Division bit-position.
.equ  _GMACCLKMSK,    (0X07 << 18)  @ MDC Clock Division bit-mask.
.equ  _GMACCLK8,      (0 << 18)     @ MDC Clock MCLK/8 (MCK up to 20 MHz).
.equ  _GMACCLK16,     (1 << 18)     @ MDC Clock MCLK/16 (MCK up to 40 MHz).
.equ  _GMACCLK32,     (2 << 18)     @ MDC Clock MCLK/32 (MCK up to 80 MHz).
.equ  _GMACCLK48,     (3 << 18)     @ MDC Clock MCLK/48 (MCK up to 120 MHz).
.equ  _GMACCLK64,     (4 << 18)     @ MDC Clock MCLK/64 (MCK up to 160 MHz).
.equ  _GMACCLK96,     (5 << 18)     @ MDC Clock MCLK/96 (MCK up to 240 MHz).
.equ  _GMACDBWMSK,    (0X03 << 21)  @ Data Bus Width bit-mask.
.equ  _GMACDCPF,      (1 << 23)     @ Disable Copy of Pause Frames.
.equ  _GMACRXCOEN,    (1 << 24)     @ Receive Checksum Offload Enable.
.equ  _GMACEFRHD,     (1 << 25)     @ Enable Frames Received in Half Duplex.
.equ  _GMACIRXFCS,    (1 << 26)     @ Ignore RX FCS.
.equ  _GMACIPGSEN,    (1 << 28)     @ IP Stretch Enable.
.equ  _GMACRXBP,      (1 << 29)     @ Receive Bad Preamble
.equ  _GMACIRXER,     (1 << 30)     @ Ignore IPG GRXER.
@ GMAC_NSR Network Status Register.
.equ  _GMACMDIO,      (1 << 1)      @ MDIO Input Status.
.equ  _GMACIDLE,      (1 << 2)      @ PHY Management Logic Idle.
@ GMAC_UR User Register.
.equ  _GMACRMII,      (1 << 0)      @ Reduced MMI Mode.
@ GMAC_DCFGR DMA Configuration Register.
.equ  _GMACFBLDOMSK,  (0X1F << 0)   @ Fixed Burst Length for DMA Data Operations bit-mask.
.equ  _GMACESMA,      (1 << 6)      @ Endian Swap Mode Enable for Management Descriptor Accesses.
.equ  _GMACESPA,      (1 << 7)      @ Endian Swap Mode Enable for Oacket Data Accesses
.equ  _GMACRXBMSMSK,  (0X03 << 8)   @ Receiver Packet Buffer Memory Size Select bit-mask.
.equ  _GMACTXPBMS,    (1 << 10)     @ Transmitter Packet Buffer Memory Size Select.
.equ  _GMACTXCOEN,    (1 << 11)     @ Transmitter Checksum Generation Offload Enable.
.equ  _GMACDRBSMSK,   (0XFF << 16)  @ DMA Receive Buffer Size bit-mask.
.equ  _GMACDDRP,      (1 << 24)     @ DMA Discard Receive Packets.
@ GMAC_TSR Transmit Status Register.
.equ  _GMACUBR,       (1 << 0)      @ Used Bit Read.
.equ  _GMACCOL,       (1 << 1)      @ Collision Occured.
.equ  _GMACRLE,       (1 << 2)      @ Retry Limit Exceeded.
.equ  _GMACTXGO,      (1 << 3)      @ Transmit Go.
.equ  _GMACTFC,       (1 << 4)      @ Transmit Frame Corruption Due to AHB Error.
.equ  _GMACTXCOMP,    (1 << 5)      @ Transmit Complete.
.equ  _GMACHRESP,     (1 << 8)      @ HRESP Not OK.
@ GMAC_RSR Receive Status Register.
.equ  _GMACBNA,       (1 << 0)      @ Buffer Not Available.
.equ  _GMACREC,       (1 << 1)      @ Frame Received.
.equ  _GMACRXOVR,     (1 << 2)      @ Receive Overrun.
.equ  _GMACHNO,       (1 << 3)      @ HRESP Not OK.
@ GMAC ISR Interrupt Enable/Disable/Status/Mask Register.
.equ  _GMACMFS,       (1 << 0)      @ Management Frame Sent.
.equ  _GMACRCOMP,     (1 << 1)      @ Receive Complete.
.equ  _GMACRXUBR,     (1 << 2)      @ RX Used Bit Read.
.equ  _GMACTXUBR,     (1 << 3)      @ TX Used Bit Read.
.equ  _GMACTUR,       (1 << 4)      @ Transmit Underrun.
.equ  _GMACRLEX,      (1 << 5)      @ Retry Limit Exceeded.
.equ  _GMACITFC,      (1 << 6)      @ Transmit Frame Corruption Due to AHB Error.
.equ  _GMACTCOMP,     (1 << 7)      @ Transmit Complete.
.equ  _GMACROVR,      (1 << 10)     @ Receive Overrun.
.equ  _GMACIHRESP,    (1 << 11)     @ HRESP Not OK.
.equ  _GMACPFNZ,      (1 << 12)     @ Pause Frame with Non-Sero Pause Quantum Received.
.equ  _GMACPTZ,       (1 << 13)     @ Pause Time Zero.
.equ  _GMACPFTR,      (1 << 14)     @ Pause Frame Transmitted.
.equ  _GMACDRQFR,     (1 << 18)     @ PTP Delay Request Frame Received.
.equ  _GMACSFR,       (1 << 19)     @ PTP Sync Frame Received.
.equ  _GMACDRQFT,     (1 << 20)     @ PTP Delay Request Frame Transmitted.
.equ  _GMACSFT,       (1 << 21)     @ PTP Sync Frame Transmitted.
.equ  _GMACPDRQFR,    (1 << 22)     @ PDelay Request Frame Received.
.equ  _GMACPDRSFR,    (1 << 23)     @ PDelay Response Frame Received.
.equ  _GMACPDRQFT,    (1 << 24)     @ PDelay Request Frame Transmitted.
.equ  _GMACPDRSFT,    (1 << 25)     @ PDelay Response Frame Transmitted.
.equ  _GMACSRI,       (1 << 26)     @ TSU Seconds Register Increment.
.equ  _GMACWOL,       (1 << 28)     @ Wake On LAN.
@ GMAC_MAN PHY Maintenance Register.
.equ  _PHYDATAMSK,    (0XFFFF << 0) @ Data bit-mask.
.equ  _PHYWTN,        (2 << 16)     @ Write ten (required).
.equ  _PHYREGAPOS,    18            @ Register Address bit-position.
.equ  _PHYREGAMSK,    (0X1F << 18)  @ Register Address bit-mask.
.equ  _PHYPHYAPOS,    23            @ PHY Address bit-position.
.equ  _PHYPHYAMSK,    (0X1F << 23)  @ PHY Address bit-mask.
.equ  _PHYWR,         (1 << 28)     @ PHY write operation.
.equ  _PHYRD,         (2 << 28)     @ PHY read operation.
.equ  _PHYCLTTO22,    (1 << 30)     @ Clause 22 operation.
.equ  _PHYWZO,        (0 << 31)     @ Must be Zero.
@-----------------------------------------------------------------------------
@ XDMAC Direct Memory Access Controller offsets from group base address.
.equ  _XDMACGTYPEV,   0X0000      @ Global Type Register offset.
.equ  _XDMACGCFGV,    0X0004      @ Global Configuration Register offset.
.equ  _XDMACGWACV,    0X0008      @ Global Weighted Arbiter Configuration Register offset.
.equ  _XDMACGIEV,     0X000C      @ Global Interrupt Enable Register offset.
.equ  _XDMACGIDV,     0X0010      @ Global Interrupt Disable Register offset.
.equ  _XDMACGIMV,     0X0014      @ Global Interrupt Mask Register offset.
.equ  _XDMACGISV,     0X0018      @ Global Intrerupt Status Register offset.
.equ  _XDMACGEV,      0X001C      @ Global Channel Enable Register offset.
.equ  _XDMACGDV,      0X0020      @ Global Channel Disable Register offset.
.equ  _XDMACGSV,      0X0024      @ Global Channel Status Register offset.
.equ  _XDMACGRSV,     0X0028      @ Global Channel Read Suspend Register offset.
.equ  _XDMACGWSV,     0X002C      @ Global Channel Write Suspend Register offset.
.equ  _XDMACGRWSV,    0X0030      @ Global Channel Read Write Suspend Register offset.
.equ  _XDMACGRWRV,    0X0034      @ Global Channel Read Write Resume Register offset.
.equ  _XDMACGSWRV,    0X0038      @ Global Channel Software Request Register offset.
.equ  _XDMACGSWSV,    0X003C      @ Global Channel Software Request Status Registr offset.
.equ  _XDMACGSWFV,    0X0040      @ Global Channel Software Fush Request Register offset.
.equ  _XDMACCIEV,     0X0050      @ Channel Interrupt Enable Register offset.
.equ  _XDMACCIDV,     0X0054      @ Channel Interrupt Disable Register offset.
.equ  _XDMACCIMV,     0X0058      @ Channel Interrupt Mask Register offset.
.equ  _XDMACCISV,     0X005C      @ Channel Interrupt Status Register offset.
.equ  _XDMACCSAV,     0X0060      @ Channel Source Address Register offset.
.equ  _XDMACCDAV,     0X0064      @ Channel Destination Address Register offset.
.equ  _XDMACCNDAV,    0X0068      @ Channel Next Descriptor Address Register offset.
.equ  _XDMACCNDCV,    0X006C      @ Channel Next Descriptor Control Register offset.
.equ  _XDMACCUBCV,    0X0070      @ Channel Microblock Control Register offset.
.equ  _XDMACCBCV,     0X0074      @ Channel Block Control Register offset.
.equ  _XDMACCCV,      0X0078      @ Channel Configuration Register offset.
.equ  _XDMACCDSMSPV,  0X007C      @ Channel Data Stride Memory Set Pattern Register offset.
.equ  _XDMACCSUSV,    0X0080      @ Channel Source MicroblockStride Register offset.
.equ  _XDMACCDUSV,    0X0084      @ Channel Destination Microblock Stride Register offset.
@-----------------------------------------------------------------------------
@ XDMAC Register definitions.
.equ  _XDMAC,       0X40078000
.equ  _XDMACGTYPE,  (_XDMAC + _XDMACGTYPEV) @ Global Type Register.
.equ  _XDMACGCFG,   (_XDMAC + _XDMACGCFGV)  @ Global Configuration Register.
.equ  _XDMACGWAC,   (_XDMAC + _XDMACGWACV)  @ Global Weighted Arbiter Configuration Register.
.equ  _XDMACGIE,    (_XDMAC + _XDMACGIEV)   @ Global Interrupt Enable Register.
.equ  _XDMACGID,    (_XDMAC + _XDMACGIDV)   @ Global Interrupt Disable Register.
.equ  _XDMACGIM,    (_XDMAC + _XDMACGIMV)   @ Global Interrupt Mask Register.
.equ  _XDMACGIS,    (_XDMAC + _XDMACGISV)   @ Global Intrerupt Status Register.
.equ  _XDMACGE,     (_XDMAC + _XDMACGEV)    @ Global Channel Enable Register.
.equ  _XDMACGD,     (_XDMAC + _XDMACGDV)    @ Global Channel Disable Register.
.equ  _XDMACGS,     (_XDMAC + _XDMACGSV)    @ Global Channel Status Register.
.equ  _XDMACGRS,    (_XDMAC + _XDMACGRSV)   @ Global Channel Read Suspend Register
.equ  _XDMACGWS,    (_XDMAC + _XDMACGWSV)   @ Global Channel Write Suspend Register.
.equ  _XDMACGRWS,   (_XDMAC + _XDMACGRWSV)  @ Global Channel Read Write Suspend Register.
.equ  _XDMACGRWR,   (_XDMAC + _XDMACGRWRV)  @ Global Channel Read Write Resume Register.
.equ  _XDMACGSWR,   (_XDMAC + _XDMACGSWRV)  @ Global Channel Software Request Register.
.equ  _XDMACGSWS,   (_XDMAC + _XDMACGSWSV)  @ Global Channel Software Request Status Registr.
.equ  _XDMACGSWF,   (_XDMAC + _XDMACGSWFV)  @ Global Channel Software Fush Request Register.
.equ  _XDMACCIE,    (_XDMAC + _XDMACCIEV)   @ Channel Interrupt Enable Register.
.equ  _XDMACCID,    (_XDMAC + _XDMACCIDV)   @ Channel Interrupt Disable Register.
.equ  _XDMACCIM,    (_XDMAC + _XDMACCIMV)   @ Channel Interrupt Mask Register.
.equ  _XDMACCIS,    (_XDMAC + _XDMACCISV)   @ Channel Interrupt Status Register.
.equ  _XDMACCSA,    (_XDMAC + _XDMACCSAV)   @ Channel Source Address Register.
.equ  _XDMACCDA,    (_XDMAC + _XDMACCDAV)   @ Channel Destination Address Register.
.equ  _XDMACCNDA,   (_XDMAC + _XDMACCNDAV)  @ Channel Next Descriptor Address Register.
.equ  _XDMACCNDC,   (_XDMAC + _XDMACCNDCV)  @ Channel Next Descriptor Control Register.
.equ  _XDMACCUBC,   (_XDMAC + _XDMACCUBCV)  @ Channel Microblock Control Register.
.equ  _XDMACCBC,    (_XDMAC + _XDMACCBCV)   @ Channel Block Control Register.
.equ  _XDMACCC,     (_XDMAC + _XDMACCCV)    @ Channel Configuration Register.
.equ  _XDMACCDSMSP, (_XDMAC + _XDMACCDSMSPV)@ Channel Data Stride Memory Set Pattern Register.
.equ  _XDMACCSUS,   (_XDMAC + _XDMACCSUSV)  @ Channel Source Microblock Stride Register.
.equ  _XDMACCDUS,   (_XDMAC + _XDMACCDUSV)  @ Channel Destination Microblock Stride Register.
@-----------------------------------------------------------------------------
@ XDMAC Register bit-field definitions.
@ XDMAC_GCFG Global Configuration Register.
.equ  _DMACGDISREG,   (1 << 0)        @ Configuration Registers Clock Gating Disable.
.equ  _DMACGDISPIPE,  (1 << 1)        @ Pipeline Clock Gating Disable.
.equ  _DMACGDISFIFO,  (1 << 2)        @ FIFO Clock Gating Disable.
.equ  _DMACGDISIF,    (1 << 3)        @ Bus Interface Clock Gating Disable.
.equ  _DMABXKBEN,     (1 << 8)        @ Boundry X Kilobyte Enable.
@ XDMA Channel bit positions.
.equ  _DMACH00,       (1 << 0)        @ DMA Channel 0.
.equ  _DMACH01,       (1 << 1)        @ DMA Channel 1.
.equ  _DMACH02,       (1 << 2)        @ DMA Channel 2.
.equ  _DMACH03,       (1 << 3)        @ DMA Channel 3.
.equ  _DMACH04,       (1 << 4)        @ DMA Channel 4.
.equ  _DMACH05,       (1 << 5)        @ DMA Channel 5.
.equ  _DMACH06,       (1 << 6)        @ DMA Channel 6.
.equ  _DMACH07,       (1 << 7)        @ DMA Channel 7.
.equ  _DMACH08,       (1 << 8)        @ DMA Channel 8.
.equ  _DMACH09,       (1 << 9)        @ DMA Channel 9.
.equ  _DMACH10,       (1 << 10)       @ DMA Channel 10.
.equ  _DMACH11,       (1 << 11)       @ DMA Channel 11.
.equ  _DMACH12,       (1 << 12)       @ DMA Channel 12.
.equ  _DMACH13,       (1 << 13)       @ DMA Channel 13.
.equ  _DMACH14,       (1 << 14)       @ DMA Channel 14.
.equ  _DMACH15,       (1 << 15)       @ DMA Channel 15.
.equ  _DMACH16,       (1 << 16)       @ DMA Channel 16.
.equ  _DMACH17,       (1 << 17)       @ DMA Channel 17.
.equ  _DMACH18,       (1 << 18)       @ DMA Channel 18.
.equ  _DMACH19,       (1 << 19)       @ DMA Channel 19.
.equ  _DMACH20,       (1 << 20)       @ DMA Channel 20.
.equ  _DMACH21,       (1 << 21)       @ DMA Channel 21.
.equ  _DMACH22,       (1 << 22)       @ DMA Channel 22.
.equ  _DMACH23,       (1 << 23)       @ DMA Channel 23.
@ XDMA Interrupt bit positions.
.equ  _DMABI,         (1 << 0)        @ End of Block Interrupt.
.equ  _DMALI,         (1 << 1)        @ End of Linked List Interrupt.
.equ  _DMADI,         (1 << 2)        @ End of Disable Interrupt.
.equ  _DMAFI,         (1 << 3)        @ End of Flush Interrupt.
.equ  _DMARBEI,       (1 << 4)        @ Read Bus Error Interrupt.
.equ  _DMAWBEI,       (1 << 5)        @ Write Bus Error Interrupt.
.equ  _DMAROI,        (1 << 6)        @ Request Overflow Error Interrupt.
@-----------------------------------------------------------------------------
@ True Random Number Generator offsets from group base address.
.equ  _TRNGCRV,       0X0000      @ Control Register offset.
.equ  _TRNGIERV,      0X0010      @ Interrupt Enable Register offset.
.equ  _TRNGIDRV,      0X0014      @ Interrupt Disable Register offset.
.equ  _TRNGIMRV,      0X0018      @ Interrupt Mask Register offset.
.equ  _TRNGISRV,      0X001C      @ Interrupt Status Register offset.
.equ  _TRNGODATAV,    0X0050      @ Output Data Register offset.
@-----------------------------------------------------------------------------
@ True Random Number Generator Register definitions.
.equ  _TRNG,        0X40070000
.equ  _TRNGCR,      (_TRNG + _TRNGCRV)    @ Control Register.
.equ  _TRNGIER,     (_TRNG + _TRNGIERV)   @ Interrupt Enable Register.
.equ  _TRNGIDR,     (_TRNG + _TRNGIDRV)   @ Interrupt Disable Register.
.equ  _TRNGIMR,     (_TRNG + _TRNGIMRV)   @ Interrupt Mask Register.
.equ  _TRNGISR,     (_TRNG + _TRNGISRV)   @ Interrupt Status Register.
.equ  _TRNGODATA,   (_TRNG + _TRNGODATAV) @ Output Data Register.
@-----------------------------------------------------------------------------
@ TRNG Register bit-field definitions.
.equ  _RNGKEY,        (0X524E47 << 8)     @ Control Register Key.
.equ  _RNGENABLE,     (1 << 0)            @ TRNG Enable.
.equ  _RNGDATRDY,     (1 << 0)            @ TRNG Data Ready.
@-----------------------------------------------------------------------------
@ ADC Register offsets from group base address.
.equ  _ADCCRV,        0X0000      @ Control Register offset.
.equ  _ADCMRV,        0X0004      @ Mode Register offset.
.equ  _ADCSEQR1V,     0X0008      @ Channel Sequence Register 1 offset.
.equ  _ADCSEQR2V,     0X000C      @ Channel Sequence Register 2 offset.
.equ  _ADCCHERV,      0X0010      @ Channel Enable Register offset.
.equ  _ADCCHDRV,      0X0014      @ Channel Disable Register offset.
.equ  _ADCCHSRV,      0X0018      @ Channel Status Register offset.
.equ  _ADCLCDRV,      0X0020      @ Last Converted Data Register offset.
.equ  _ADCIERV,       0X0024      @ Interrupt Enable Register offset.
.equ  _ADCIDRV,       0X0028      @ Interrupt Disable Register offset.
.equ  _ADCIMRV,       0X002C      @ Interrupt Mask Register offset.
.equ  _ADCISRV,       0X0030      @ Interrupt Status Register offset.
.equ  _ADCOVERV,      0X003C      @ Overrun Status Register offset.
.equ  _ADCEMRV,       0X0040      @ Extended Mode Register offset.
.equ  _ADCCWRV,       0X0044      @ Compare Window Register offset.
.equ  _ADCCGRV,       0X0048      @ Channel Gain Register offset.
.equ  _ADCCORV,       0X004C      @ Channel Offset Register offset.
.equ  _ADCCDR0V,      0X0050      @ Channel Data Register 0 offset.
.equ  _ADCCDR1V,      0X0054      @ Channel Data Register 1 offset.
.equ  _ADCCDR2V,      0X0058      @ Channel Data Register 2 offset.
.equ  _ADCCDR3V,      0X005C      @ Channel Data Register 3 offset.
.equ  _ADCCDR4V,      0X0060      @ Channel Data Register 4 offset.
.equ  _ADCCDR5V,      0X0064      @ Channel Data Register 5 offset.
.equ  _ADCCDR6V,      0X0068      @ Channel Data Register 6 offset.
.equ  _ADCCDR7V,      0X006C      @ Channel Data Register 7 offset.
.equ  _ADCCDR8V,      0X0070      @ Channel Data Register 8 offset.
.equ  _ADCCDR9V,      0X0074      @ Channel Data Register 9 offset.
.equ  _ADCCDR10V,     0X0078      @ Channel Data Register 10 offset.
.equ  _ADCCDR11V,     0X007C      @ Channel Data Register 11 offset.
.equ  _ADCCDR12V,     0X0080      @ Channel Data Register 12 offset.
.equ  _ADCCDR13V,     0X0084      @ Channel Data Register 13 offset.
.equ  _ADCCDR14V,     0X0088      @ Channel Data Register 14 offset.
.equ  _ADCCDR15V,     0X008C      @ Channel Data Register 15 offset.
.equ  _ADCACRV,       0X0094      @ Analog Control Register offset.
.equ  _ADCWPMRV,      0X00E4      @ Write Protect Mode Register offset.
.equ  _ADCWPSRV,      0X00E8      @ Write Protect Status Register offset.
@-----------------------------------------------------------------------------
@ MATRIX
.equ  _MATRIX,        0X40088000          @
.equ  _CCFG_SYSIO,    (_MATRIX + 0X0114)  @
@ CCFG_SYSIO bit field definitions.
.equ  _CCFG_SYSIO4,   (1 << 4)            @ PB4 - TDI
.equ  _CCFG_SYSIO5,   (1 << 5)            @ PB5 - TDO
.equ  _CCFG_SYSIO6,   (1 << 6)            @ PB6 - TMS
.equ  _CCFG_SYSIO7,   (1 << 7)            @ PB7 - TCK
.equ  _CCFG_SYSIO12,  (1 << 12)           @ PB12 - ERASE
@-----------------------------------------------------------------------------
@ Analog to Digital Controller Register definitions.
.equ  _ADC,         0X400C0000          @ ADC register group base address.
.equ  _ADCCR,      (_ADC + _ADCCRV)     @ Control Register.
.equ  _ADCMR,      (_ADC + _ADCMRV)     @ Mode Register.
.equ  _ADCSEQR1,   (_ADC + _ADCSEQR1V)  @ Channel Sequence Register 1.
.equ  _ADCSEQR2,   (_ADC + _ADCSEQR2V)  @ Channel Sequence Register 2.
.equ  _ADCCHER,    (_ADC + _ADCCHERV)   @ Channel Enable Register.
.equ  _ADCCHDR,    (_ADC + _ADCCHDRV)   @ Channel Disable Register.
.equ  _ADCCHSR,    (_ADC + _ADCCHSRV)   @ Channel Status Register.
.equ  _ADCLCDR,    (_ADC + _ADCLCDRV)   @ Last Converted Data Register.
.equ  _ADCIER,     (_ADC + _ADCIERV)    @ Interrupt Enable Register.
.equ  _ADCIDR,     (_ADC + _ADCIDRV)    @ Interrupt Disable Register.
.equ  _ADCIMR,     (_ADC + _ADCIMRV)    @ Interrupt Mask Register.
.equ  _ADCISR,     (_ADC + _ADCISRV)    @ Interrupt Status Register.
.equ  _ADCOVER,    (_ADC + _ADCOVERV)   @ Overrun Status Register.
.equ  _ADCEMR,     (_ADC + _ADCEMRV)    @ Extended Mode Register.
.equ  _ADCCWR,     (_ADC + _ADCCWRV)    @ Compare Window Register.
.equ  _ADCCGR,     (_ADC + _ADCCGRV)    @ Channel Gain Register.
.equ  _ADCCOR,     (_ADC + _ADCCORV)    @ Channel Offset Register.
.equ  _ADCCDR0,    (_ADC + _ADCCDR0V)   @ Channel Data Register 0.
.equ  _ADCCDR1,    (_ADC + _ADCCDR1V)   @ Channel Data Register 1.
.equ  _ADCCDR2,    (_ADC + _ADCCDR2V)   @ Channel Data Register 2.
.equ  _ADCCDR3,    (_ADC + _ADCCDR3V)   @ Channel Data Register 3.
.equ  _ADCCDR4,    (_ADC + _ADCCDR4V)   @ Channel Data Register 4.
.equ  _ADCCDR5,    (_ADC + _ADCCDR5V)   @ Channel Data Register 5.
.equ  _ADCCDR6,    (_ADC + _ADCCDR6V)   @ Channel Data Register 6.
.equ  _ADCCDR7,    (_ADC + _ADCCDR7V)   @ Channel Data Register 7.
.equ  _ADCCDR8,    (_ADC + _ADCCDR8V)   @ Channel Data Register 8.
.equ  _ADCCDR9,    (_ADC + _ADCCDR9V)   @ Channel Data Register 9.
.equ  _ADCCDR10,   (_ADC + _ADCCDR10V)  @ Channel Data Register 10.
.equ  _ADCCDR11,   (_ADC + _ADCCDR11V)  @ Channel Data Register 11.
.equ  _ADCCDR12,   (_ADC + _ADCCDR12V)  @ Channel Data Register 12.
.equ  _ADCCDR13,   (_ADC + _ADCCDR13V)  @ Channel Data Register 13.
.equ  _ADCCDR14,   (_ADC + _ADCCDR14V)  @ Channel Data Register 14.
.equ  _ADCCDR15,   (_ADC + _ADCCDR15V)  @ Channel Data Register 15.
.equ  _ADCACR,     (_ADC + _ADCACRV)    @ Analog Control Register.
.equ  _ADCWPMR,    (_ADC + _ADCWPMRV)   @ Write Protect Mode Register.
.equ  _ADCWPSR,    (_ADC + _ADCWPSRV)   @ Write Protect Status Register.
@-----------------------------------------------------------------------------
@ ADC Control Register bit-field definitions.
.equ  _SWRST,     (1 << 0)        @ ADC Software Reset.
.equ  _START,     (1 << 1)        @ ADC Start Conversion.
@ ADC Mode Register bit-field definitions.
.equ  _TRGEN,     (1 << 0)        @ ADC Trigger Enable.
.equ  _TRGSELMSK, (0X0007 << 1)   @ ADC Trigger Selection bit-mask.
.equ  _TRIG0,     (0X0000 << 1)   @ External : ADCTRG.
.equ  _TRIG1,     (0X0001 << 1)   @ TIOA Output of Timer Counter Channel 0.
.equ  _TRIG2,     (0X0002 << 1)   @ TIOA Output of Timer Counter Channel 1.
.equ  _TRIG3,     (0X0003 << 1)   @ TIOA Output of Timer Counter Channel 2.
.equ  _TRIG4,     (0X0004 << 1)   @ PWM Event Line 0.
.equ  _TRIG5,     (0X0005 << 1)   @ PWM Event Line 0.
.equ  _BITS12,    (0X0000 << 4)   @ ADC 12-Bit Resolution.
.equ  _BITS10,    (0X0001 << 4)   @ ADC 10-Bit Resolution.
.equ  _SLEEP,     (0X0001 << 5)   @ ADC Sleep Mode.
.equ  _FWUP,      (0X0001 << 6)   @ ADC Fast Wake Up Mode.
.equ  _FREERUN,   (0X0001 << 7)   @ ADC Free Run Mode.
.equ  _PRESCALMSK,(0X00FF << 8)   @ Prescaler Rate Selection Mask: MCLK/((PRESCAL+1)*2).
.equ  _SUT0,      (0X0000 << 16)  @ ADC Start Up Time 0 periods of ADCClock.
.equ  _SUT8,      (0X0001 << 16)  @ ADC Start Up Time 8 periods of ADCClock.
.equ  _SUT16,     (0X0002 << 16)  @ ADC Start Up Time 16 periods of ADCClock.
.equ  _SUT24,     (0X0003 << 16)  @ ADC Start Up Time 24 periods of ADCClock.
.equ  _SUT64,     (0X0004 << 16)  @ ADC Start Up Time 64 periods of ADCClock.
.equ  _SUT80,     (0X0005 << 16)  @ ADC Start Up Time 80 periods of ADCClock.
.equ  _SUT96,     (0X0006 << 16)  @ ADC Start Up Time 96 periods of ADCClock.
.equ  _SUT112,    (0X0007 << 16)  @ ADC Start Up Time 112 periods of ADCClock.
.equ  _SUT512,    (0X0008 << 16)  @ ADC Start Up Time 512 periods of ADCClock.
.equ  _SUT576,    (0X0009 << 16)  @ ADC Start Up Time 576 periods of ADCClock.
.equ  _SUT640,    (0X000A << 16)  @ ADC Start Up Time 640 periods of ADCClock.
.equ  _SUT704,    (0X000B << 16)  @ ADC Start Up Time 740 periods of ADCClock.
.equ  _SUT768,    (0X000C << 16)  @ ADC Start Up Time 768 periods of ADCClock.
.equ  _SUT832,    (0X000D << 16)  @ ADC Start Up Time 832 periods of ADCClock.
.equ  _SUT896,    (0X000E << 16)  @ ADC Start Up Time 896 periods of ADCClock.
.equ  _SUT960,    (0X000F << 16)  @ ADC Start Up Time 960 periods of ADCClock.
.equ  _AST3,      (0X0000 << 20)  @ Analog Settling Time : 3 periods of ADCClock.
.equ  _AST5,      (0X0001 << 20)  @ Analog Settling Time : 5 periods of ADCClock.
.equ  _AST9,      (0X0002 << 20)  @ Analog Settling Time : 9 periods of ADCClock.
.equ  _AST17,     (0X0003 << 20)  @ Analog Settling Time : 17 periods of ADCClock.
.equ  _ANACH,     (0X0001 << 23)  @ Allows different analog settings for each channel.
.equ  _USEQ,      (0X0001 << 31)  @ User Sequence Mode.
@ ADC Analog Channel bit-fields.
.equ  _ADCCH0,    (0X0001 << 0)   @ Analog Channel 0.
.equ  _ADCCH1,    (0X0001 << 1)   @ Analog Channel 1.
.equ  _ADCCH2,    (0X0001 << 2)   @ Analog Channel 2.
.equ  _ADCCH3,    (0X0001 << 3)   @ Analog Channel 3.
.equ  _ADCCH4,    (0X0001 << 4)   @ Analog Channel 4.
.equ  _ADCCH5,    (0X0001 << 5)   @ Analog Channel 5.
.equ  _ADCCH6,    (0X0001 << 6)   @ Analog Channel 6.
.equ  _ADCCH7,    (0X0001 << 7)   @ Analog Channel 7.
.equ  _ADCCH8,    (0X0001 << 8)   @ Analog Channel 8.
.equ  _ADCCH9,    (0X0001 << 9)   @ Analog Channel 9.
.equ  _ADCCH10,   (0X0001 << 10)  @ Analog Channel 10.
.equ  _ADCCH11,   (0X0001 << 11)  @ Analog Channel 11.
.equ  _ADCCH12,   (0X0001 << 12)  @ Analog Channel 12.
.equ  _ADCCH13,   (0X0001 << 13)  @ Analog Channel 13.
.equ  _ADCCH14,   (0X0001 << 14)  @ Analog Channel 14.
.equ  _ADCCH15,   (0X0001 << 15)  @ Analog Channel 15.
@ ADC Analog Control Register.
.equ  _TSON,      (0X0001 << 4)   @ Temperature Sensor On.
@-----------------------------------------------------------------------------
@ PMC Register offsets from group base address.
.equ  _PMCSCERV,      0X0000      @ System Clock Enable Register offset.
.equ  _PMCSCDRV,      0X0004      @ System Clock Disable Register offset.
.equ  _PMCSCSRV,      0X0008      @ System Clock Status Register offset.
.equ  _PMCPCER0V,     0X0010      @ Peripheral Clock Enable Register 0 offset.
.equ  _PMCPCDR0V,     0X0014      @ Peripheral Clock Disable Register 0 offset.
.equ  _PMCPCSR0V,     0X0018      @ Peripheral Clock Status Register 0 offset.
.equ  _CKGRUCKRV,     0X001C      @ UTMI Clock Register offset.
.equ  _CKGRMORV,      0X0020      @ Main Oscillator Register offset.
.equ  _CKGRMCFRV,     0X0024      @ Main Clock Frequency Register offset.
.equ  _CKGRPLLARV,    0X0028      @ PLLA Register offset.
.equ  _PMCMCKRV,      0X0030      @ Master Clock Register offset.
.equ  _PMCUSBV,       0X0038      @ USB Clock Register offset.
.equ  _PMCPCLK0V,     0X0040      @ Programmable Clock 0 Register offset.
.equ  _PMCPCLK1V,     0X0044      @ Programmable Clock 1 Register offset.
.equ  _PMCPCLK2V,     0X0048      @ Programmable Clock 2 Register offset.
.equ  _PMCIERV,       0X0060      @ Interrupt Enable Register offset.
.equ  _PMCIDRV,       0X0064      @ Interrupt Disable Register offset.
.equ  _PMCSRV,        0X0068      @ Status Register offset.
.equ  _PMCIMRV,       0X006C      @ Interrupt Mask Register offset.
.equ  _PMCFSMRV,      0X0070      @ Fast Startup Mode Register offset.
.equ  _PMCFSPRV,      0X0074      @ Fast Startup Polarity Register offset.
.equ  _PMCFOCRV,      0X0078      @ Fault Output Clear Register offset.
.equ  _PMCWPMRV,      0X00E4      @ Write Protect Mode Register offset.
.equ  _PMCWPSRV,      0X00E8      @ Write Protect Status Register offset.
.equ  _PMCPCER1V,     0X0100      @ Peripheral Clock Enable Register 1 offset.
.equ  _PMCPCDR1V,     0X0104      @ Peripheral Clock Disable Register 1 offset.
.equ  _PMCPCSR1V,     0X0108      @ Peripheral Clock Status Register 1 offset.
.equ  _PMCPCRV,       0X010C      @ Peripheral Control Register offset.
@-----------------------------------------------------------------------------
@ Power Management Controller Register definitions.
.equ  _PMC,         0X400E0600          @ PMC register group base address.
.equ  _PMCSCER,    (_PMC + _PMCSCERV)   @ System Clock Enable Register.
.equ  _PMCSCDR,    (_PMC + _PMCSCDRV)   @ System Clock Disable Register.
.equ  _PMCSCSR,    (_PMC + _PMCSCSRV)   @ System Clock Status Register.
.equ  _PMCPCER0,   (_PMC + _PMCPCER0V)  @ Peripheral Clock Enable Register 0.
.equ  _PMCPCDR0,   (_PMC + _PMCPCDR0V)  @ Peripheral Clock Disable Register 0.
.equ  _PMCPCSR0,   (_PMC + _PMCPCSR0V)  @ Peripheral Clock Status Register 0.
.equ  _CKGRUCKR,   (_PMC + _CKGRUCKRV)  @ UTMI Clock Register.
.equ  _CKGRMOR,    (_PMC + _CKGRMORV)   @ Main Oscillator Register.
.equ  _CKGRMCFR,   (_PMC + _CKGRMCFRV)  @ Main Clock Frequency Register.
.equ  _CKGRPLLAR,  (_PMC + _CKGRPLLARV) @ PLLA Register.
.equ  _PMCMCKR,    (_PMC + _PMCMCKRV)   @ Master Clock Register.
.equ  _PMCUSB,     (_PMC + _PMCUSBV)    @ USB Clock Register.
.equ  _PMCPCLK0,   (_PMC + _PMCPCLK0V)  @ Programmable Clock 0 Register.
.equ  _PMCPCLK1,   (_PMC + _PMCPCLK1V)  @ Programmable Clock 1 Register.
.equ  _PMCPCLK2,   (_PMC + _PMCPCLK2V)  @ Programmable Clock 2 Register.
.equ  _PMCIER,     (_PMC + _PMCIERV)    @ Interrupt Enable Register.
.equ  _PMCIDR,     (_PMC + _PMCIDRV)    @ Interrupt Disable Register.
.equ  _PMCSR,      (_PMC + _PMCSRV)     @ Status Register.
.equ  _PMCIMR,     (_PMC + _PMCIMRV)    @ Interrupt Mask Register.
.equ  _PMCFSMR,    (_PMC + _PMCFSMRV)   @ Fast Startup Mode Register.
.equ  _PMCFSPR,    (_PMC + _PMCFSPRV)   @ Fast Startup Polarity Register.
.equ  _PMCFOCR,    (_PMC + _PMCFOCRV)   @ Fault Output Clear Register.
.equ  _PMCWPMR,    (_PMC + _PMCWPMRV)   @ Write Protect Mode Register.
.equ  _PMCWPSR,    (_PMC + _PMCWPSRV)   @ Write Protect Status Register.
.equ  _PMCPCER1,   (_PMC + _PMCPCER1V)  @ Peripheral Clock Enable Register 1.
.equ  _PMCPCDR1,   (_PMC + _PMCPCDR1V)  @ Peripheral Clock Disable Register 1.
.equ  _PMCPCSR1,   (_PMC + _PMCPCSR1V)  @ Peripheral Clock Status Register 1.
.equ  _PMCPCR,     (_PMC + _PMCPCRV)    @ Peripheral Control Register.
@-----------------------------------------------------------------------------
@ PMC Bit-Field definitions.
@ SCER,SCDR,SCSR - System Clock Enable/Disable/Status Register.
.equ  _PMCPCK6,         (1 << 14)       @ Programmable Clock Enable 6.
.equ  _PMCPCK5,         (1 << 13)       @ Programmable Clock Enable 5.
.equ  _PMCPCK4,         (1 << 12)       @ Programmable Clock Enable 4.
.equ  _PMCPCK3,         (1 << 11)       @ Programmable Clock Enable 3.
.equ  _PMCPCK2,         (1 << 10)       @ Programmable Clock Enable 2.
.equ  _PMCPCK1,         (1 << 9)        @ Programmable Clock Enable 1.
.equ  _PMCPCK0,         (1 << 8)        @ Programmable Clock Enable 0.
.equ  _PMCUSBCLK,       (1 << 5)        @ USB FS Clock Enable.
@ CKG_MOR - Clock Generator Main Oscillator Register.
.equ  _CKGRT32KFME,     (1 << 26)       @ 32768Hz Crystal Oscillator Frequency Monitoring Enable.
.equ  _CKGRCFDN,        (1 << 25)       @ Clock Failure Detection Enable.
.equ  _CKGRMORMOSCSEL,  (1 << 24)       @ Main Clock Oscillator Selection.
.equ  _CKGRMORKEY,      (0X37 << 16)    @ CKG_MOR Key (PASSWD).
.equ  _CKGRMORCEN,      (1 << 3)        @ 4/8/12Mhz On Chip RC Oscillator Enable.
.equ  _CKGRMORTMODE,    (1 << 2)        @ Wait Mode Command bit-position.
.equ  _CKGRMORMOSCXTBY, (1 << 1)        @ 3-20MHz Crystal Oscillator Bypass.
.equ  _CKGRMORMOSCXTEN, (1 << 0)        @ 3-20MHz Crystal Oscillator Enable.
@ GKGR_MCFR - Clock Generator Main Clock Frequency Register.
.equ  _CKGRCCSS,        (1 << 24)       @ Counter Clock Source election.
.equ  _CKGRRCMEAS,      (1 << 20)       @ RC Oscillator Frequency Measure.
.equ  _CKGRMAINFRDY,    (1 << 16)       @ Main Clock Frequency Measyre Ready.
.equ  _CKGRMAINFMSK,    (0XFFFF << 0)   @ Main Clock Frequency bit-mask.
@ PMC_PLLAR - Clock Generator or PLLA Register.
.equ  _PMCPLLAONE,      (1 << 29)       @ ONE : Must be set to 1.
.equ  _PMCMULAMSK,      (0X07FF << 16)  @ MULA bit-mask.
.equ  _PMCPLLACOUNTMSK, (0X003F << 8)   @ PLLA bit-mask.
.equ  _PMCDIVAMSK,      (0X00FF << 0)   @ DIVA bit-mask.
.equ  _PMCPLLAMULA13,   (13 << 16)      @ MULA / 13 + 1.
.equ  _PMCPLLAMULA24,   (24 << 16)      @ MULA / 24 + 1.
.equ  _PMCPLLACOUNT63,  (63 << 8)       @ PLLA count 63.
.equ  _PCMPLLADIVA1,    (1 << 0)        @ DIVA / 1.
@ PMC Master Clock Register Bit-Field definitions.
.equ  _PMCUPLLDIV2,     (1 << 13)
.equ  _PMCPLLADIV2,     (1 << 12)
.equ  _PMCPRESMSK,      (7 << 4)
.equ  _PMCCSSMSK,       (3 << 0)
.equ  _PMCSLOWCLK,      0X0000
.equ  _PMCMAINCLK,      0X0001
.equ  _PMCPLAACLK,      0X0002
.equ  _PMCUPLLCLK,      0X0003
.equ  _PMCPRESCLK,      0X0000
.equ  _PMCPRESCLK2,     0X0010
.equ  _PMCPRESCLK4,     0X0020
.equ  _PMCPRESCLK8,     0X0030
.equ  _PMCPRESCLK16,    0X0040
.equ  _PMCPRESCLK32,    0X0050
.equ  _PMCPRESCLK64,    0X0060
.equ  _PMCPRESCLK3,     0X0070
@ PMC_SR Status Register.
.equ  _PMCXT32KERR,     (1 << 21)       @ Slow Crystal Oscillator Error.
.equ  _PMCFOS,          (1 << 20)       @ Clock Failure Detector Fault Output Status.
.equ  _PMCCFDS,         (1 << 19)       @ Clock Failure Detector Status.
.equ  _PMCCFDEV,        (1 << 18)       @ Clock Failure Detector Event.
.equ  _PMCMOSCRCS,      (1 << 17)       @ 4/8/12 MHz RC Oscillator Status.
.equ  _PMCMOSCSELS,     (1 << 16)       @ Main Clock Source Oscillator Selection Status.
.equ  _PMCPCKRDY2,      (1 << 10)       @ Programmable Clock Ready Status.
.equ  _PMCPCKRDY1,      (1 << 9)        @ Programmable Clock Ready Status.
.equ  _PMCPCKRDY0,      (1 << 9)        @ Programmable Clock Ready Status.
.equ  _PMCOSCSELS,      (1 << 7)        @ Slow Clock Source Oscillator Selection.
.equ  _PMCLOCKU,        (1 << 6)        @ UTMI PLL Lock Status.
.equ  _PMCMCKRDY,       (1 << 3)        @ Master Clock Status.
.equ  _PMCLOCKA,        (1 << 1)        @ PLLA Lock Status.
.equ  _PMCMOSCXTS,      (1 << 0)        @ 3-20MHz Crystal Oscillator Status.
@ PMC_FOCR - Fault Output Clear Register.
.equ  _PMCFOCLR,        (1 << 0)        @ Fault Output Clear.
@ PMC Peripheral Control Register Bit-Field definitions.
.equ  _PMCGCLKEN,       (1 << 29)       @ Enable Genric Clock.
.equ  _PMCPCREN,        (1 << 28)       @ Enable.
.equ  _PMCPCRCMD,       (1 << 12)       @ Command Write/Read.
.equ  _PMCCLKGCSSSLOW,  (0 << 8)        @ Slow Clock.
.equ  _PMCCLKGCSSMAIN,  (1 << 8)        @ Main Clock.
.equ  _PMCCLKGCSSPLLA,  (2 << 8)        @ PLLA Clock.
.equ  _PMCCLKGCSSUPLL,  (3 << 8)        @ UPLL Clock.
.equ  _PMCCLKGCSSMCLK,  (4 << 8)        @ Master Clock.
.equ  _PMCPCRPIDMSK,    (0X7F << 0)     @ PID Mask.
@-----------------------------------------------------------------------------
@ UART Register offsets from group base address.
.equ _UARTCRV,      0X0000      @ Control Register.
.equ _UARTMRV,      0X0004      @ Mode Register.
.equ _UARTIERV,     0X0008      @ Interrupt Enable Register.
.equ _UARTIDRV,     0X000C      @ Interrupt Disable Register.
.equ _UARTIMRV,     0X0010      @ Interrupt Mask Register.
.equ _UARTSRV,      0X0014      @ Status Register.
.equ _UARTRHRV,     0X0018      @ Receive Holding Register.
.equ _UARTTHRV,     0X001C      @ Transmit Holding Register.
.equ _UARTBRGRV,    0X0020      @ Baud Rate Generator Register.
.equ _PERIPHTCRV,   0X0120      @ Peripheral DMA Transfer Control Register.
@-----------------------------------------------------------------------------
@ UART Register definitions.
.equ _UART,     0X400E0800              @ UART register group base address.
.equ _UARTCR,   (_UART + _UARTCRV)      @ UART Control Register.
.equ _UARTMR,   (_UART + _UARTMRV)      @ UART Mode Register.
.equ _UARTIER,  (_UART + _UARTIERV)     @ UART Interrupt Enable Register.
.equ _UARTIDR,  (_UART + _UARTIDRV)     @ UART Interrupt Disable Register.
.equ _UARTIMR,  (_UART + _UARTIMRV)     @ UART Interrupt Mask Register.
.equ _UARTSR,   (_UART + _UARTSRV)      @ UART Status Register.
.equ _UARTRHR,  (_UART + _UARTRHRV)     @ UART Receive Holding Register.
.equ _UARTTHR,  (_UART + _UARTTHRV)     @ UART Transmit Holding Register.
.equ _UARTBRGR, (_UART + _UARTBRGRV)    @ UART BAUD Rate Generator Register.
.equ _PERIPHTCR,(_UART + _PERIPHTCRV)   @ UART PDC Transfer Control Register.
@-----------------------------------------------------------------------------
@ UART_CR Control Register.
.equ _RSTRX,      (1 << 2)        @ Reset Receiver.
.equ _RSTTX,      (1 << 3)        @ Reset Transmitter.
.equ _RXEN,       (1 << 4)        @ Receiver Enable.
.equ _RXDIS,      (1 << 5)        @ Receiver Disable.
.equ _TXEN,       (1 << 6)        @ Transmitter Enable.
.equ _TXDIS,      (1 << 7)        @ Transmitter Disable.
.equ _RSTSTA,     (1 << 8)        @ Reset Status.
.equ _REQCLR,     (1 << 12)       @ Request Clear.
@ UART_MR Mode Register.
.equ _RXFILTER,   (1 << 4)        @ Receiver Digital Filter.
.equ _PAREVEN,    (0 << 9)        @ Parity - Even.
.equ _PARODD,     (1 << 9)        @ Parity - Odd.
.equ _PARSPACE,   (2 << 9)        @ Parity - Space (forced to 0).
.equ _PARMARK,    (3 << 9)        @ Parity - Mark (forced to 1).
.equ _PARNONE,    (4 << 9)        @ Parity - None.
.equ _BRSBCCK,    (1 << 12)       @ BAUD Rate Source Clock.
.equ _MODNORMAL,  (0 << 14)       @ Channel Mode - Normal.
.equ _MODECHO,    (1 << 14)       @ Channel Mode - Echo.
.equ _MODLOOPLOC, (2 << 14)       @ Channel Mode - Local Loopback.
.equ _MODLOOPREM, (3 << 14)       @ Channel Mode - Remote Loopback.
@ UART_IER Interrupt/Status/Mask Registers.
.equ _RXRDY,      (1 << 0)        @ Receiver Ready.
.equ _TXRDY,      (1 << 1)        @ transmitter Ready Interrupt.
.equ _OVRE,       (1 << 5)        @ Overrun Error.
.equ _FRAME,      (1 << 6)        @ Framing Error.
.equ _PARE,       (1 << 7)        @ Parity Error.
.equ _TXEMPTY,    (1 << 9)        @ Transmit Buffer Empty.
.equ _RXCMP,      (1 << 15)       @ Comparison.
@ UART_WPMR Write Mode Protection Register.
.equ _UARTWPKEY,  0X55415200      @ Write Protection Key (PASSWD).
.equ _UARTWPEN,   (1 << 0)        @ Write Protection Enable.
@-----------------------------------------------------------------------------
@ EEFC0 Register offsets from group base address.
.equ  _EEFCFMRV,    0X0000    @ Flash Mode Register offset.
.equ  _EEFCFCRV,    0X0004    @ Flash Command Register offset.
.equ  _EEFCFSRV,    0X0008    @ Flash Status Register offset.
.equ  _EFFCFRRV,    0X000C    @ Flash Result Register offset.
.equ  _EEFCWPMRV,   0X00E4    @ Write Protection Register offset.
@-----------------------------------------------------------------------------
@ Enhanced Embedded Flash Controller Register definitions.
.equ  _EFC,       0X400E0C00              @ EFFC register group base address.
.equ  _EFFC0FMR,  (_EFC + _EEFCFMRV)      @ Flash Mode Register.
.equ  _EFFC0FCR,  (_EFC + _EEFCFCRV)      @ Flash Command Register.
.equ  _EFFC0FSR,  (_EFC + _EEFCFSRV)      @ Flash Status Register.
.equ  _EFFC0FRR,  (_EFC + _EEFCFRRV)      @ Flash Result Register.
@-----------------------------------------------------------------------------
@ EEFC Bit Field definitions.
.equ  _EFFC_FRDY,   (1 << 0)              @ Flash Ready Interrupt enable.
.equ  _EFFC_FWS1,   (1 << 8)              @ 1 (+1) wait states.
.equ  _EFFC_FWS2,   (2 << 8)              @ 2 (+1) wait states.
.equ  _EFFC_FWS3,   (3 << 8)              @ 3 (+1) wait states.
.equ  _EFFC_FWS4,   (4 << 8)              @ 4 (+1) wait states.
.equ  _EFFC_FWS5,   (5 << 8)              @ 5 (+1) wait states.
.equ  _EFFC_FWS6,   (6 << 8)              @ 6 (+1) wait states.
.equ  _EFFC_FWS7,   (7 << 8)              @ 7 (+1) wait states.
.equ  _EFFC_FWS8,   (8 << 8)              @ 8 (+1) wait states.
.equ  _EFFC_FWS9,   (9 << 8)              @ 9 (+1) wait states.
.equ  _EFFC_FWS10,  (10 << 8)             @ 10 (+1) wait states.
.equ  _EFFC_FWS11,  (11 << 8)             @ 11 (+1) wait states.
.equ  _EFFC_FWS12,  (12 << 8)             @ 12 (+1) wait states.
.equ  _EFFC_FWS13,  (13 << 8)             @ 13 (+1) wait states.
.equ  _EFFC_FWS14,  (14 << 8)             @ 14 (+1) wait states.
.equ  _EFFC_FWS15,  (15 << 8)             @ 15 (+1) wait states.
.equ  _EFFC_SCOD,   (1 << 16)             @ Sequential Code Optimization disable.
.equ  _EFFC_CLOE,   (1 << 26)             @ Code Loop Optimization enable.
@-----------------------------------------------------------------------------
@ Parallel Input/Output Controller.
@-----------------------------------------------------------------------------
@ PIO Register offsets from group base address.
.equ  _PIOPERV,     0X0000  @ Enable Register.
.equ  _PIOPDRV,     0X0004  @ Disable Register.
.equ  _PIOPSRV,     0X0008  @ Status Register.
.equ  _PIOOERV,     0X0010  @ Output Enable Register.
.equ  _PIOODRV,     0X0014  @ Output Disable Register.
.equ  _PIOOSRV,     0X0018  @ Output Status Register.
.equ  _PIOIFERV,    0X0020  @ Input Filter Enable Register.
.equ  _PIOIFDRV,    0X0024  @ Input Filter Disable Register.
.equ  _PIOIFSRV,    0X0028  @ Input Filter Status Register.
.equ  _PIOSODRV,    0X0030  @ Set Output Data Register.
.equ  _PIOCODRV,    0X0034  @ Clear Output Data Register.
.equ  _PIOODSRV,    0X0038  @ Output Data Status Register.
.equ  _PIOPDSRV,    0X003C  @ Pin Data Status Register.
.equ  _PIOIERV,     0X0040  @ Interrupt Enable Register.
.equ  _PIOIDRV,     0X0044  @ Interrupt Disable Register.
.equ  _PIOIMRV,     0X0048  @ Interrupt Mask Register.
.equ  _PIOISRV,     0X004C  @ Interrupt Status Register.
.equ  _PIOMDERV,    0X0050  @ Multi-Driver Enable Register.
.equ  _PIOMDDRV,    0X0054  @ Multi-Driver Disable Register.
.equ  _PIOMDSRV,    0X0058  @ Multi-Driver Status Register.
.equ  _PIOPUDRV,    0X0060  @ Pull Up Disable Register.
.equ  _PIOPUERV,    0X0064  @ Pull Up Enable Register.
.equ  _PIOPUSRV,    0X0068  @ Pull Up Status Register.
.equ  _PIOABSR1V,   0X0070  @ Peripheral Select Register 1.
.equ  _PIOABSR2V,   0X0074  @ Peripheral Select Register 2.
.equ  _PIOSCIFSRV,  0X0080  @ System Clock Glitch Input Filter Select Register.
.equ  _PIODIFSRV,   0X0084  @ Debouncing Input Filter Select Register.
.equ  _PIOIFDGSRV,  0X0088  @ Glitch or Debouncing Input Filter Selection Status Register.
.equ  _PIOSCRDV,    0X008C  @ Slow Clock Divider Debouncing Register.
.equ  _PIOPDDRV,    0X0090  @ Pull Down Disable Register.
.equ  _PIOPDERV,    0X0094  @ Pull Down Enable Register.
.equ  _PIOPPDSRV,   0X0098  @ Pull Down Status Register.
.equ  _PIOOWERV,    0X00A0  @ Output Write Enable Register.
.equ  _PIOOWDRV,    0X00A4  @ Output Write Disable Register.
.equ  _PIOOWSRV,    0X00A8  @ Output Write Status Register.
.equ  _PIOAIMERV,   0X00B0  @ Additional Interrupt Modes Enable Register.
.equ  _PIOAIMDRV,   0X00B4  @ Additional Interrupt Modes Disable Register.
.equ  _PIOAIMMRV,   0X00B8  @ Additional Interrupt Modes Mask Register.
.equ  _PIOESRV,     0X00C0  @ Edge Select Register.
.equ  _PIOLSRV,     0X00C4  @ Level Select Register.
.equ  _PIOELSRV,    0X00C8  @ Edge/Level Status Register.
.equ  _PIOFELLSRV,  0X00D0  @ Falling Edge/Low Level Select Register.
.equ  _PIOREHLSRV,  0X00D4  @ Rising Edge/High Level Select Register.
.equ  _PIOFRLHSRV,  0X00D8  @ Fall/Rise Low/High Status Register.
.equ  _PIOLOCKSRV,  0X00E0  @ Lock Status Register.
.equ  _PIOWPMRV,    0X00E4  @ Write Protect Mode Register.
.equ  _PIOWPSRV,    0X00E8  @ Write Protect Status Register.
@-----------------------------------------------------------------------------
@ PIO Controller Register definitions.
.equ  _PIOA,        0X400E0E00
.equ  _PIOAPER,     (_PIOA + _PIOPERV)    @ PIOA Enable Register.
.equ  _PIOAPDR,     (_PIOA + _PIOPDRV)    @ PIOA Disable Regiter.
.equ  _PIOAPSR,     (_PIOA + _PIOPSRV)    @ PIOA Status Register.
.equ  _PIOAOER,     (_PIOA + _PIOOERV)    @ PIOA Output Enable Register.
.equ  _PIOAODR,     (_PIOA + _PIOODRV)    @ PIOA Output Disable Register.
.equ  _PIOAOSR,     (_PIOA + _PIOOSRV)    @ PIOA Output Status Register.
.equ  _PIOAIFER,    (_PIOA + _PIOIFERV)   @ PIOA Input Filter Enable Register.
.equ  _PIOAIFDR,    (_PIOA + _PIOIFDRV)   @ PIOA Input Filter Disable Register.
.equ  _PIOAIFSR,    (_PIOA + _PIOIFSRV)   @ PIOA Input Filter Status Register.
.equ  _PIOASODR,    (_PIOA + _PIOSODRV)   @ PIOA Set Output Data Register.
.equ  _PIOACODR,    (_PIOA + _PIOCODRV)   @ PIOA Clear Output Data Register.
.equ  _PIOAODSR,    (_PIOA + _PIOODSRV)   @ PIOA Output Data Status Register.
.equ  _PIOAPDSR,    (_PIOA + _PIOPDSRV)   @ PIOA Pin Data Status Register.
.equ  _PIOAIER,     (_PIOA + _PIOIERV)    @ PIOA Interrupt Enable Register.
.equ  _PIOAIDR,     (_PIOA + _PIOIDRV)    @ PIOA Interrupt Disable Register.
.equ  _PIOAIMR,     (_PIOA + _PIOIMRV)    @ PIOA Interrupt Mask Register.
.equ  _PIOAISR,     (_PIOA + _PIOISRV)    @ PIOA Interrupt Status Register.
.equ  _PIOAMDER,    (_PIOA + _PIOMDERV)   @ PIOA Multi-Driver Enable Register.
.equ  _PIOAMDDR,    (_PIOA + _PIOMDDRV)   @ PIOA Multi-Driver Disable Register.
.equ  _PIOAMDSR,    (_PIOA + _PIOMDSRV)   @ PIOA Multi-Driver Status Register.
.equ  _PIOAPUDR,    (_PIOA + _PIOPUDRV)   @ PIOA Pull Up Disable Register.
.equ  _PIOAPUER,    (_PIOA + _PIOPUERV)   @ PIOA Pull Up Enable Register.
.equ  _PIOAPUSR,    (_PIOA + _PIOPUSRV)   @ PIOA Pull Up Status Register.
.equ  _PIOAABSR1,   (_PIOA + _PIOABSR1V)  @ PIOA Peripheral Select Register 1.
.equ  _PIOAABSR2,   (_PIOA + _PIOABSR2V)  @ PIOA Peripheral Select Register 2.
.equ  _PIOASCIFSR,  (_PIOA + _PIOSCIFSRV) @ PIOA System Clock Glitch Input Filter Select Register.
.equ  _PIOADIFSR,   (_PIOA + _PIODIFSRV)  @ PIOA Debouncing Input Filter Select Register.
.equ  _PIOAIFDGSR,  (_PIOA + _PIOIFDGSRV) @ PIOA Glitch or Debouncing Input Filter Selection Status Register.
.equ  _PIOASCRD,    (_PIOA + _PIOSCRDV)   @ PIOA Slow Clock Divider Debouncing Register.
.equ  _PIOAPDDR,    (_PIOA + _PIOPDDRV)   @ PIOA Pull Down Disable Register.
.equ  _PIOAPDER,    (_PIOA + _PIOPDERV)   @ PIOA Pull Down Enable Register.
.equ  _PIOAPDSR,    (_PIOA + _PIOPPDSRV)  @ PIOA Pull Down Status Register.
.equ  _PIOAOWER,    (_PIOA + _PIOOWERV)   @ PIOA Output Write Enable Register.
.equ  _PIOAOWDR,    (_PIOA + _PIOOWDRV)   @ PIOA Output Write Disable Register.
.equ  _PIOAOWSR,    (_PIOA + _PIOOWSRV)   @ PIOA Output Write Status Register.
.equ  _PIOAAIMER,   (_PIOA + _PIOAIMERV)  @ PIOA Additional Interrupt Modes Enable Register.
.equ  _PIOAAIMDR,   (_PIOA + _PIOAIMDRV)  @ PIOA Additional Interrupt Modes Disable Register.
.equ  _PIOAAIMMR,   (_PIOA + _PIOAIMMRV)  @ PIOA Additional Interrupt Modes Mask Register.
.equ  _PIOAESR,     (_PIOA + _PIOESRV)    @ PIOA Edge Select Register.
.equ  _PIOALSR,     (_PIOA + _PIOLSRV)    @ PIOA Level Select Register.
.equ  _PIOAELSR,    (_PIOA + _PIOELSRV)   @ PIOA Edge/Level Status Register.
.equ  _PIOAFELLSR,  (_PIOA + _PIOFELLSRV) @ PIOA Falling Edge/Low Level Select Register.
.equ  _PIOAREHLSR,  (_PIOA + _PIOREHLSRV) @ PIOA Rising Edge/High Level Select Register.
.equ  _PIOAFRLHSR,  (_PIOA + _PIOFRLHSRV) @ PIOA Fall/Rise Low/High Status Register.
.equ  _PIOALOCKSR,  (_PIOA + _PIOLOCKSRV) @ PIOA Lock Status Register.
.equ  _PIOAWPMR,    (_PIOA + _PIOWPMRV)   @ PIOA Write Protect Mode Register.
.equ  _PIOAWPSR,    (_PIOA + _PIOWPSRV)   @ PIOA Write Protect Status Register.
.equ  _PIOB,        0X400E1000
.equ  _PIOBPER,     (_PIOB + _PIOPERV)    @ PIOB Enable Register.
.equ  _PIOBPDR,     (_PIOB + _PIOPDRV)    @ PIOB Disable Regiter.
.equ  _PIOBPSR,     (_PIOB + _PIOPSRV)    @ PIOB Status Register.
.equ  _PIOBOER,     (_PIOB + _PIOOERV)    @ PIOB Output Enable Register.
.equ  _PIOBODR,     (_PIOB + _PIOODRV)    @ PIOB Output Disable Register.
.equ  _PIOBOSR,     (_PIOB + _PIOOSRV)    @ PIOB Output Status Register.
.equ  _PIOBIFER,    (_PIOB + _PIOIFERV)   @ PIOB Input Filter Enable Register.
.equ  _PIOBIFDR,    (_PIOB + _PIOIFDRV)   @ PIOB Input Filter Disable Register.
.equ  _PIOBIFSR,    (_PIOB + _PIOIFSRV)   @ PIOB Input Filter Status Register.
.equ  _PIOBSODR,    (_PIOB + _PIOSODRV)   @ PIOB Set Output Data Register.
.equ  _PIOBCODR,    (_PIOB + _PIOCODRV)   @ PIOB Clear Output Data Register.
.equ  _PIOBODSR,    (_PIOB + _PIOODSRV)   @ PIOB Output Data Status Register.
.equ  _PIOBPDSR,    (_PIOB + _PIOPDSRV)   @ PIOB Pin Data Status Register.
.equ  _PIOBIER,     (_PIOB + _PIOIERV)    @ PIOB Interrupt Enable Register.
.equ  _PIOBIDR,     (_PIOB + _PIOIDRV)    @ PIOB Interrupt Disable Register.
.equ  _PIOBIMR,     (_PIOB + _PIOIMRV)    @ PIOB Interrupt Mask Register.
.equ  _PIOBISR,     (_PIOB + _PIOISRV)    @ PIOB Interrupt Status Register.
.equ  _PIOBMDER,    (_PIOB + _PIOMDERV)   @ PIOB Multi-Driver Enable Register.
.equ  _PIOBMDDR,    (_PIOB + _PIOMDDRV)   @ PIOB Multi-Driver Disable Register.
.equ  _PIOBMDSR,    (_PIOB + _PIOMDSRV)   @ PIOB Multi-Driver Status Register.
.equ  _PIOBPUDR,    (_PIOB + _PIOPUDRV)   @ PIOB Pull Up Disable Register.
.equ  _PIOBPUER,    (_PIOB + _PIOPUERV)   @ PIOB Pull Up Enable Register.
.equ  _PIOBPUSR,    (_PIOB + _PIOPUSRV)   @ PIOB Pull Up Status Register.
.equ  _PIOBABSR1,   (_PIOB + _PIOABSR1V)  @ PIOB Peripheral Select Register 1.
.equ  _PIOBABSR2,   (_PIOB + _PIOABSR2V)  @ PIOB Peripheral Select Register 2.
.equ  _PIOBSCIFSR,  (_PIOB + _PIOSCIFSRV) @ PIOB System Clock Glitch Input Filter Select Register.
.equ  _PIOBDIFSR,   (_PIOB + _PIODIFSRV)  @ PIOB Debouncing Input Filter Select Register.
.equ  _PIOBIFDGSR,  (_PIOB + _PIOIFDGSRV) @ PIOB Glitch or Debouncing Input Filter Selection Status Register.
.equ  _PIOBSCRD,    (_PIOB + _PIOSCRDV)   @ PIOB Slow Clock Divider Debouncing Register.
.equ  _PIOBOWER,    (_PIOB + _PIOOWERV)   @ PIOB Output Write Enable Register.
.equ  _PIOBOWDR,    (_PIOB + _PIOOWDRV)   @ PIOB Output Write Disable Register.
.equ  _PIOBOWSR,    (_PIOB + _PIOOWSRV)   @ PIOB Output Write Status Register.
.equ  _PIOBAIMER,   (_PIOB + _PIOAIMERV)  @ PIOB Additional Interrupt Modes Enable Register.
.equ  _PIOBAIMDR,   (_PIOB + _PIOAIMDRV)  @ PIOB Additional Interrupt Modes Disable Register.
.equ  _PIOBAIMMR,   (_PIOB + _PIOAIMMRV)  @ PIOB Additional Interrupt Modes Mask Register.
.equ  _PIOBESR,     (_PIOB + _PIOESRV)    @ PIOB Edge Select Register.
.equ  _PIOBLSR,     (_PIOB + _PIOLSRV)    @ PIOB Level Select Register.
.equ  _PIOBELSR,    (_PIOB + _PIOELSRV)   @ PIOB Edge/Level Status Register.
.equ  _PIOBFELLSR,  (_PIOB + _PIOFELLSRV) @ PIOB Falling Edge/Low Level Select Register.
.equ  _PIOBREHLSR,  (_PIOB + _PIOREHLSRV) @ PIOB Rising Edge/High Level Select Register.
.equ  _PIOBFRLHSR,  (_PIOB + _PIOFRLHSRV) @ PIOB Fall/Rise Low/High Status Register.
.equ  _PIOBLOCKSR,  (_PIOB + _PIOLOCKSRV) @ PIOB Lock Status Register.
.equ  _PIOBWPMR,    (_PIOB + _PIOWPMRV)   @ PIOB Write Protect Mode Register.
.equ  _PIOBWPSR,    (_PIOB + _PIOWPSRV)   @ PIOB Write Protect Status Register.
.equ  _PIOC,        0X400E1200
.equ  _PIOCPER,     (_PIOC + _PIOPERV)    @ PIOC Enable Register.
.equ  _PIOCPDR,     (_PIOC + _PIOPDRV)    @ PIOC Disable Regiter.
.equ  _PIOCPSR,     (_PIOC + _PIOPSRV)    @ PIOC Status Register.
.equ  _PIOCOER,     (_PIOC + _PIOOERV)    @ PIOC Output Enable Register.
.equ  _PIOCODR,     (_PIOC + _PIOODRV)    @ PIOC Output Disable Register.
.equ  _PIOCOSR,     (_PIOC + _PIOOSRV)    @ PIOC Output Status Register.
.equ  _PIOCIFER,    (_PIOC + _PIOIFERV)   @ PIOC Input Filter Enable Register.
.equ  _PIOCIFDR,    (_PIOC + _PIOIFDRV)   @ PIOC Input Filter Disable Register.
.equ  _PIOCIFSR,    (_PIOC + _PIOIFSRV)   @ PIOC Input Filter Status Register.
.equ  _PIOCSODR,    (_PIOC + _PIOSODRV)   @ PIOC Set Output Data Register.
.equ  _PIOCCODR,    (_PIOC + _PIOCODRV)   @ PIOC Clear Output Data Register.
.equ  _PIOCODSR,    (_PIOC + _PIOODSRV)   @ PIOC Output Data Status Register.
.equ  _PIOCPDSR,    (_PIOC + _PIOPDSRV)   @ PIOC Pin Data Status Register.
.equ  _PIOCIER,     (_PIOC + _PIOIERV)    @ PIOC Interrupt Enable Register.
.equ  _PIOCIDR,     (_PIOC + _PIOIDRV)    @ PIOC Interrupt Disable Register.
.equ  _PIOCIMR,     (_PIOC + _PIOIMRV)    @ PIOC Interrupt Mask Register.
.equ  _PIOCISR,     (_PIOC + _PIOISRV)    @ PIOC Interrupt Status Register.
.equ  _PIOCMDER,    (_PIOC + _PIOMDERV)   @ PIOC Multi-Driver Enable Register.
.equ  _PIOCMDDR,    (_PIOC + _PIOMDDRV)   @ PIOC Multi-Driver Disable Register.
.equ  _PIOCMDSR,    (_PIOC + _PIOMDSRV)   @ PIOC Multi-Driver Status Register.
.equ  _PIOCPUDR,    (_PIOC + _PIOPUDRV)   @ PIOC Pull Up Disable Register.
.equ  _PIOCPUER,    (_PIOC + _PIOPUERV)   @ PIOC Pull Up Enable Register.
.equ  _PIOCPUSR,    (_PIOC + _PIOPUSRV)   @ PIOC Pull Up Status Register.
.equ  _PIOCABSR1,   (_PIOC + _PIOABSR1V)  @ PIOC Peripheral Select Register 1.
.equ  _PIOCABSR2,   (_PIOC + _PIOABSR2V)  @ PIOC Peripheral Select Register 2.
.equ  _PIOCSCIFSR,  (_PIOC + _PIOSCIFSRV) @ PIOC System Clock Glitch Input Filter Select Register.
.equ  _PIOCDIFSR,   (_PIOC + _PIODIFSRV)  @ PIOC Debouncing Input Filter Select Register.
.equ  _PIOCIFDGSR,  (_PIOC + _PIOIFDGSRV) @ PIOC Glitch or Debouncing Input Filter Selection Status Register.
.equ  _PIOCSCRD,    (_PIOC + _PIOSCRDV)   @ PIOC Slow Clock Divider Debouncing Register.
.equ  _PIOCOWER,    (_PIOC + _PIOOWERV)   @ PIOC Output Write Enable Register.
.equ  _PIOCOWDR,    (_PIOC + _PIOOWDRV)   @ PIOC Output Write Disable Register.
.equ  _PIOCOWSR,    (_PIOC + _PIOOWSRV)   @ PIOC Output Write Status Register.
.equ  _PIOCAIMER,   (_PIOC + _PIOAIMERV)  @ PIOC Additional Interrupt Modes Enable Register.
.equ  _PIOCAIMDR,   (_PIOC + _PIOAIMDRV)  @ PIOC Additional Interrupt Modes Disable Register.
.equ  _PIOCAIMMR,   (_PIOC + _PIOAIMMRV)  @ PIOC Additional Interrupt Modes Mask Register.
.equ  _PIOCESR,     (_PIOC + _PIOESRV)    @ PIOC Edge Select Register.
.equ  _PIOCLSR,     (_PIOC + _PIOLSRV)    @ PIOC Level Select Register.
.equ  _PIOCELSR,    (_PIOC + _PIOELSRV)   @ PIOC Edge/Level Status Register.
.equ  _PIOCFELLSR,  (_PIOC + _PIOFELLSRV) @ PIOC Falling Edge/Low Level Select Register.
.equ  _PIOCREHLSR,  (_PIOC + _PIOREHLSRV) @ PIOC Rising Edge/High Level Select Register.
.equ  _PIOCFRLHSR,  (_PIOC + _PIOFRLHSRV) @ PIOC Fall/Rise Low/High Status Register.
.equ  _PIOCLOCKSR,  (_PIOC + _PIOLOCKSRV) @ PIOC Lock Status Register.
.equ  _PIOCWPMR,    (_PIOC + _PIOWPMRV)   @ PIOC Write Protect Mode Register.
.equ  _PIOCWPSR,    (_PIOC + _PIOWPSRV)   @ PIOC Write Protect Status Register.
.equ  _PIOD,        0X400E1400
.equ  _PIODPER,     (_PIOD + _PIOPERV)    @ PIOD Enable Register.
.equ  _PIODPDR,     (_PIOD + _PIOPDRV)    @ PIOD Disable Regiter.
.equ  _PIODPSR,     (_PIOD + _PIOPSRV)    @ PIOD Status Register.
.equ  _PIODOER,     (_PIOD + _PIOOERV)    @ PIOD Output Enable Register.
.equ  _PIODODR,     (_PIOD + _PIOODRV)    @ PIOD Output Disable Register.
.equ  _PIODOSR,     (_PIOD + _PIOOSRV)    @ PIOD Output Status Register.
.equ  _PIODIFER,    (_PIOD + _PIOIFERV)   @ PIOD Input Filter Enable Register.
.equ  _PIODIFDR,    (_PIOD + _PIOIFDRV)   @ PIOD Input Filter Disable Register.
.equ  _PIODIFSR,    (_PIOD + _PIOIFSRV)   @ PIOD Input Filter Status Register.
.equ  _PIODSODR,    (_PIOD + _PIOSODRV)   @ PIOD Set Output Data Register.
.equ  _PIODCODR,    (_PIOD + _PIOCODRV)   @ PIOD Clear Output Data Register.
.equ  _PIODODSR,    (_PIOD + _PIOODSRV)   @ PIOD Output Data Status Register.
.equ  _PIODPDSR,    (_PIOD + _PIOPDSRV)   @ PIOD Pin Data Status Register.
.equ  _PIODIER,     (_PIOD + _PIOIERV)    @ PIOD Interrupt Enable Register.
.equ  _PIODIDR,     (_PIOD + _PIOIDRV)    @ PIOD Interrupt Disable Register.
.equ  _PIODIMR,     (_PIOD + _PIOIMRV)    @ PIOD Interrupt Mask Register.
.equ  _PIODISR,     (_PIOD + _PIOISRV)    @ PIOD Interrupt Status Register.
.equ  _PIODMDER,    (_PIOD + _PIOMDERV)   @ PIOD Multi-Driver Enable Register.
.equ  _PIODMDDR,    (_PIOD + _PIOMDDRV)   @ PIOD Multi-Driver Disable Register.
.equ  _PIODMDSR,    (_PIOD + _PIOMDSRV)   @ PIOD Multi-Driver Status Register.
.equ  _PIODPUDR,    (_PIOD + _PIOPUDRV)   @ PIOD Pull Up Disable Register.
.equ  _PIODPUER,    (_PIOD + _PIOPUERV)   @ PIOD Pull Up Enable Register.
.equ  _PIODPUSR,    (_PIOD + _PIOPUSRV)   @ PIOD Pull Up Status Register.
.equ  _PIODABSR1,   (_PIOD + _PIOABSR1V)  @ PIOD Peripheral Select Register 1.
.equ  _PIODABSR2,   (_PIOD + _PIOABSR2V)  @ PIOD Peripheral Select Register 2.
.equ  _PIODSCIFSR,  (_PIOD + _PIOSCIFSRV) @ PIOD System Clock Glitch Input Filter Select Register.
.equ  _PIODDIFSR,   (_PIOD + _PIODIFSRV)  @ PIOD Debouncing Input Filter Select Register.
.equ  _PIODIFDGSR,  (_PIOD + _PIOIFDGSRV) @ PIOD Glitch or Debouncing Input Filter Selection Status Register.
.equ  _PIODSCRD,    (_PIOD + _PIOSCRDV)   @ PIOD Slow Clock Divider Debouncing Register.
.equ  _PIODOWER,    (_PIOD + _PIOOWERV)   @ PIOD Output Write Enable Register.
.equ  _PIODOWDR,    (_PIOD + _PIOOWDRV)   @ PIOD Output Write Disable Register.
.equ  _PIODOWSR,    (_PIOD + _PIOOWSRV)   @ PIOD Output Write Status Register.
.equ  _PIODAIMER,   (_PIOD + _PIOAIMERV)  @ PIOD Additional Interrupt Modes Enable Register.
.equ  _PIODAIMDR,   (_PIOD + _PIOAIMDRV)  @ PIOD Additional Interrupt Modes Disable Register.
.equ  _PIODAIMMR,   (_PIOD + _PIOAIMMRV)  @ PIOD Additional Interrupt Modes Mask Register.
.equ  _PIODESR,     (_PIOD + _PIOESRV)    @ PIOD Edge Select Register.
.equ  _PIODLSR,     (_PIOD + _PIOLSRV)    @ PIOD Level Select Register.
.equ  _PIODELSR,    (_PIOD + _PIOELSRV)   @ PIOD Edge/Level Status Register.
.equ  _PIODFELLSR,  (_PIOD + _PIOFELLSRV) @ PIOD Falling Edge/Low Level Select Register.
.equ  _PIODREHLSR,  (_PIOD + _PIOREHLSRV) @ PIOD Rising Edge/High Level Select Register.
.equ  _PIODFRLHSR,  (_PIOD + _PIOFRLHSRV) @ PIOD Fall/Rise Low/High Status Register.
.equ  _PIODLOCKSR,  (_PIOD + _PIOLOCKSRV) @ PIOD Lock Status Register.
.equ  _PIODWPMR,    (_PIOD + _PIOWPMRV)   @ PIOD Write Protect Mode Register.
.equ  _PIODWPSR,    (_PIOD + _PIOWPSRV)   @ PIOD Write Protect Status Register.
@-----------------------------------------------------------------------------
@ PIO Bit-Field definitions.
.equ  _PIO00,       (1 << 0)    @ PIO Bit-0.
.equ  _PIO01,       (1 << 1)    @ PIO Bit-1.
.equ  _PIO02,       (1 << 2)    @ PIO Bit-2.
.equ  _PIO03,       (1 << 3)    @ PIO Bit-3.
.equ  _PIO04,       (1 << 4)    @ PIO Bit-4.
.equ  _PIO05,       (1 << 5)    @ PIO Bit-5.
.equ  _PIO06,       (1 << 6)    @ PIO Bit-6.
.equ  _PIO07,       (1 << 7)    @ PIO Bit-7.
.equ  _PIO08,       (1 << 8)    @ PIO Bit-8.
.equ  _PIO09,       (1 << 9)    @ PIO Bit-9.
.equ  _PIO10,       (1 << 10)   @ PIO Bit-10.
.equ  _PIO11,       (1 << 11)   @ PIO Bit-11.
.equ  _PIO12,       (1 << 12)   @ PIO Bit-12.
.equ  _PIO13,       (1 << 13)   @ PIO Bit-13.
.equ  _PIO14,       (1 << 14)   @ PIO Bit-14.
.equ  _PIO15,       (1 << 15)   @ PIO Bit-15.
.equ  _PIO16,       (1 << 16)   @ PIO Bit-16.
.equ  _PIO17,       (1 << 17)   @ PIO Bit-17.
.equ  _PIO18,       (1 << 18)   @ PIO Bit-18.
.equ  _PIO19,       (1 << 19)   @ PIO Bit-19.
.equ  _PIO20,       (1 << 20)   @ PIO Bit-20.
.equ  _PIO21,       (1 << 21)   @ PIO Bit-21.
.equ  _PIO22,       (1 << 22)   @ PIO Bit-22.
.equ  _PIO23,       (1 << 23)   @ PIO Bit-23.
.equ  _PIO24,       (1 << 24)   @ PIO Bit-24.
.equ  _PIO25,       (1 << 25)   @ PIO Bit-25.
.equ  _PIO26,       (1 << 26)   @ PIO Bit-26.
.equ  _PIO27,       (1 << 27)   @ PIO Bit-27.
.equ  _PIO28,       (1 << 28)   @ PIO Bit-28.
.equ  _PIO29,       (1 << 29)   @ PIO Bit-29.
.equ  _PIO30,       (1 << 30)   @ PIO Bit-30.
.equ  _PIO31,       (1 << 31)   @ PIO Bit-31.
@ PIO Slow Clock Divder Debouncing Register bit-field definitions.
.equ  _DIV00,       (1 << 0)
.equ  _DIV01,       (1 << 1)
.equ  _DIV02,       (1 << 2)
.equ  _DIV03,       (1 << 3)
.equ  _DIV04,       (1 << 4)
.equ  _DIV05,       (1 << 5)
.equ  _DIV06,       (1 << 6)
.equ  _DIV07,       (1 << 7)
.equ  _DIV08,       (1 << 8)
.equ  _DIV09,       (1 << 9)
.equ  _DIV10,       (1 << 10)
.equ  _DIV11,       (1 << 11)
.equ  _DIV12,       (1 << 12)
.equ  _DIV13,       (1 << 13)
@-----------------------------------------------------------------------------
@ Reset Controller.
@ RSTC Register offsets from group base address.
.equ  _RSTCCRV,     0X0000    @ Control Register offset.
.equ  _RSTCSRV,     0X0004    @ Status Register offset.
.equ  _RSTCMRV,     0X0008    @ Mode Register offset.
@-----------------------------------------------------------------------------
@ Reset Controller Register definitions.
.equ  _RSTC,        0X400E1800    @ Reset Controller register group base address.
.equ  _RSTCCR,      (_RSTC + _RSTCCRV)    @ Control Register.
.equ  _RSTCSR,      (_RSTC + _RSTCSRV)    @ Status Register.
.equ  _RSTCMR,      (_RSTC + _RSTCMRV)    @ Mode Register.
@-----------------------------------------------------------------------------
@ RSTC Bit-Field definitions.
@ RSTC_CR Control Register.
.equ  _RSTPROCRST,  (1 << 0)      @ Processor Reset.
.equ  _RSTEXTRST,   (1 << 3)      @ External Reset.
.equ  _RSTKEY,      0XA5000000    @ System Reset key (PASSWD).
@ RSTC_SR Status Register.
.equ  _RSTURSTS,    (1 << 0)      @ User Reset Status.
.equ  _RSTTYPMSK,   (7 << 8)      @ Reset Type bit-mask.
.equ  _RSTGENERAL,  (0 << 9)      @ First power-up reset.
.equ  _RSTBACKUP,   (1 << 8)      @ Return from Backup Mode.
.equ  _RSTWDT,      (2 << 8)      @ WatchDog fault occured.
.equ  _RSTSOFT,     (3 << 8)      @ Processor reset required by the software.
.equ  _RSTUSER,     (4 << 8)      @ NRST pin detected low.
.equ  _RSTNRST,     (1 << 16)     @ NRST Pin Level.
.equ  _RSTSRCMP,    (1 << 17)     @ Software Reset command in progress.
@ RSTC_MR Mode Register.
.equ  _RSTURSTEN,   (1 << 0)      @ User Reset Enable.
.equ  _RSTURSTIEN,  (1 << 4)      @ User Reset Interrupt Enable.
.equ  _RSTERSTLPOS, (1 << 8)      @ External Reset Length bits position.
.equ  _RSTERSTLMSK, (0X0F << 8)   @ External Reset Length bit-mask.
@-----------------------------------------------------------------------------
@ Supply Controller.
@ SUPC Register offsets from group base address.
.equ  _SUPCCRV,     0X0000    @ Control Register offset.
.equ  _SUPCSMMRV,   0X0004    @ Supply Monitor Mode Register offset.
.equ  _SUPCMRV,     0X0008    @ Mode Register offset.
.equ  _SUPCWUMRV,   0X000C    @ Wake-Up Mode Register offset.
.equ  _SUPCWUIRV,   0X0010    @ Wake-Up Inputs Register offset.
.equ  _SUPCSRV,     0X0014    @ Status Register offset.
@-----------------------------------------------------------------------------
@ Supply Controller Register definitions.
.equ  _SUPC,        0X400E1810            @ Supply Controller register group base address.
.equ  _SUPCCR,      (_SUPC + _SUPCCRV)    @ SUPC Control Register.
.equ  _SUPCSMMR,    (_SUPC + _SUPCSMMRV)  @ SUPC Supply Monitor Mode Register.
.equ  _SUPCMR,      (_SUPC + _SUPCMRV)    @ SUPC Mode Register.
.equ  _SUPCWUMR,    (_SUPC + _SUPCWUMRV)  @ SUPC Wake-Up Mode Register.
.equ  _SUPCWUIR,    (_SUPC + _SUPCWUIRV)  @ SUPC Wake-Up Inputs Register.
.equ  _SUPCSR,      (_SUPC + _SUPCSRV)    @ SUPC Status Register.
@-----------------------------------------------------------------------------
@ SUPC Bit-Field definitions.
.equ  _SCKEY,       0XA5000000    @ SUPC Key (PASSWD)
@ Control Register.
.equ  _SCXTALSEL,   (1 << 3)      @ Crystal Oscillator Select bit-position.
.equ  _SCVROFF,     (1 << 2)      @ Voltage Regulator Off bit-position.
@ Supply Monitor Mode Register.
.equ  _SCSMIEN,     (1 << 13)     @ Supply Monitor Interrupt Enable bit-position.
.equ  _SCSMRSTEN,   (1 << 12)     @ Supply Monitor Reset Enable bit-posision.
.equ  _SMSMPLSMD,   (0 << 8)      @ Supply Monitor Disabled bit-field.
.equ  _SMSMPLCSM,   (1 << 8)      @ Continuous Supply Monitor.
.equ  _SMSMPL32,    (2 << 8)      @ Supply Monitor one SCLK period every 32 SCLK priods.
.equ  _SMSMPL256,   (3 << 8)      @ Supply Monitor one SCLK period every 256 SCLK priods.
.equ  _SMSMPL2048,  (4 << 8)      @ Supply Monitor one SCLK period every 2048 SCLK priods.
.equ  _SCSMTHMSK,   (0X0F << 0)   @ Supply Monitor Threshold bit-mask.
@ Mode Register.
.equ  _SCOSCBYPASS, (1 << 20)     @ Oscillator Bypass bit-position.
.equ  _SCBKUPRETON, (1 << 17)     @ SRAM On In Backup Mode bit-position.
.equ  _SCONREG,     (1 << 14)     @ Voltage Regulator Enable bit-position.
.equ  _SCBODISS,    (1 << 13)     @ Brownout Decector Disable bit-position.
.equ  _SCBODRSTEN,  (1 << 12)     @ Brownout Dectector Reset Enable bit-position.
@ Wakeup Mode Register.
.equ  _SCLPDBCMSK,  (0X07 << 16)  @ Low-Power Debouncer Peroid bit-mask.
.equ  _SCWKUPDBCMSK,(0X07 << 12)  @ Wakeup Inputs Debouncer Period bit-mask.
.equ  _SCLPDBCCLR,  (1 << 7)      @ Low-Power Debouncer Clear bit-position.
.equ  _SCLPDBCEN1,  (1 << 6)      @ Low-Power Debouncer Enable WKUP1 bit-position.
.equ  _SCLPDBCEN0,  (1 << 5)      @ Low-Power Debouncer Enable WKUP0 bit-position.
.equ  _SCRTCEN,     (1 << 3)      @ Realtime Clock Wakeup Enable bit-position.
.equ  _SCRTTEN,     (1 << 2)      @ Realtime Timer Wakeup Enable bit-position.
.equ  _SCSMEN,      (1 << 1)      @ Supply Monitor Wakeup Enable bit-position.
@ Write Protection Mode Register.
.equ  _SUPCWPKEY,   0X52544300    @ Write Protection Key.
.equ  _SUPCWPEN,    (1 << 0)      @ Write Protection Enable bit-position.
@-----------------------------------------------------------------------------
@ WatchDog Timer Controller.
@-----------------------------------------------------------------------------
@ WDT Register offsets from group base address.
.equ  _WDTCRV,      0X0000    @ Control Register offset.
.equ  _WDTMRV,      0X0004    @ Mode Register offset.
.equ  _WDTSRV,      0X0008    @ Status Register offset.
@-----------------------------------------------------------------------------
@ WatchDog Register definitions.
.equ  _WDT,         0X400E1850          @ Watchdog Timer register group base address.
.equ  _WDTCR,       (_WDT + _WDTCRV)    @ WDT Control Register.
.equ  _WDTMR,       (_WDT + _WDTMRV)    @ WDT Mode Register.
.equ  _WDTSR,       (_WDT + _WDTSRV)    @ WDT Status Register.
@-----------------------------------------------------------------------------
@ Reinforced Safety WatchDog Register definitions.
.equ  _RSWDT,       0X400E1900          @ Watchdog Timer register group base address.
.equ  _RSWDTCR,     (_RSWDT + _WDTCRV)  @ RSWDT Control Register.
.equ  _RSWDTMR,     (_RSWDT + _WDTMRV)  @ RSWDT Mode Register.
.equ  _RSWDTSR,     (_RSWDT + _WDTSRV)  @ RSWDT Status Register.
@-----------------------------------------------------------------------------
@ WDT Bit-Field definitions.
.equ  _WDTKEY,      0XA5000000    @ WDT Key (PASSWD).
.equ  _RSWDTKEY,    0XC4000000    @ RSWDT Key (PASSWD).
.equ  _WDRSTT,      (1 << 0)      @ Reset Timer bit-position.
.equ  _WDIDLEHLT,   (1 << 29)     @ Watchdog Debut Halt bit-position.
.equ  _WDDBGHLT,    (1 << 28)     @ Watchdog Idle Halt bit-position.
.equ  _WDALLONES,   (0XFFF << 8)  @ Watchdog Delta Value bit mask - All oones for RSWDT.
.equ  _WDDIS,       (1 << 15)     @ Watchdog Disable bit-position.
.equ  _WDRPROC,     (1 << 14)     @ Watchdog Processor Reset bit-position.
.equ  _WDRSTEN,     (1 << 13)     @ Watchdog Reset Enable bit-position.
.equ  _WDFIEN,      (1 << 12)     @ Watchdog Fault Interrupt Enable bit-posision.
.equ  _WDERR,       (1 << 1)      @ Watchdog ERROR status bit-position.
.equ  _WDUNF,       (1 << 0)      @ Watchdog UNDERFLOW status bit-posision.
@-----------------------------------------------------------------------------
@ RTC Register offsets from group base address.
.equ  _RTCCRV,      0X0000    @ Control Register offset.
.equ  _RTCMRV,      0X0004    @ Mode Register offset.
.equ  _RTCTIMRV,    0X0008    @ Time Register offset.
.equ  _RTCCALRV,    0X000C    @ Calendar Register offset.
.equ  _RTCTIMALRV,  0X0010    @ Time Alarm Register offset.
.equ  _RTCCALALRV,  0X0014    @ Calendar Alarm Register offset.
.equ  _RTCSRV,      0X0018    @ Status Register offset.
.equ  _RTCSCCRV,    0X001C    @ Status Clear Command Register offset.
.equ  _RTCIERV,     0X0020    @ Interrupt Enable Register offset.
.equ  _RTCIDRV,     0X0024    @ Interrupt Disable Register offset.
.equ  _RTCIMRV,     0X0028    @ Interrupt Mask Register offset.
.equ  _RTCVERV,     0X002C    @ Valid Entry Register offset.
.equ  _RTCWPMRV,    0X00E4    @ Write Protection Mode Register offset.
@-----------------------------------------------------------------------------
@ Real Time Clock Register definitions.
.equ  _RTC,         0X400E1860            @ RTC Register group base address.
.equ  _RTCCR,       (_RTC + _RTCCRV)      @ Control Register.
.equ  _RTCMR,       (_RTC + _RTCMRV)      @ Mode Register.
.equ  _RTCTIMR,     (_RTC + _RTCTIMRV)    @ Time Register.
.equ  _RTCCALR,     (_RTC + _RTCCALRV)    @ Calendar Register.
.equ  _RTCTIMALR,   (_RTC + _RTCTIMALRV)  @ Time Alarm Register.
.equ  _RTCCALALR,   (_RTC + _RTCCALALRV)  @ Calendar Alarm Register.
.equ  _RTCSR,       (_RTC + _RTCSRV)      @ Status Register.
.equ  _RTCSCCR,     (_RTC + _RTCSCCRV)    @ Status Clear Command Register.
.equ  _RTCIER,      (_RTC + _RTCIERV)     @ Interrupt Enable Register.
.equ  _RTCIDR,      (_RTC + _RTCIDRV)     @ Interrupt Disable Register.
.equ  _RTCIMR,      (_RTC + _RTCIMRV)     @ Interrupt Mask Register.
.equ  _RTCVER,      (_RTC + _RTCVERV)     @ Valid Entry Register.
.equ  _RTCWPMR,     (_RTC + _RTCWPMRV)    @ Write Protection Mode Register.
@-----------------------------------------------------------------------------
@ Real Time Clock bit-field definitions.
@ RTC_CR Control Register.
.equ  _RTCUPDTM,    (1 << 0)      @ Update Request Time Register.
.equ  _RTCUPDCAL,   (1 << 1)      @ Update Request Calendar Register.
.equ  _RTCTMVSMSK,  (3 << 8)      @ Time Event Selection bit-mask.
.equ  _RTCTESMIN,   (0 << 8)      @ Minute change.
.equ  _RTCTESHOUR,  (1 << 8)      @ Hour change.
.equ  _RTCTESMIDN,  (2 << 8)      @ Everyday at midnight.
.equ  _RTCTESNOON,  (3 << 8)      @ Every day at noon.
.equ  _RTCCAVSMSK,  (3 << 16)     @ Calendar Event Selection bit-mask.
.equ  _RTCCAVSWEEK, (0 << 16)     @ Week change (every Monday at time 00:00:00).
.equ  _RTCCAVSMONTH,(1 << 16)     @ Month change (every 01 of each month at time 00:00:00).
.equ  _RTCCAVSYEAR, (2 << 16)     @ Year change (every January 01 at time 00:00:00).
@ RTC_MR Mode Register.
.equ  _RTCHRMOD,    (1 << 0)      @ 12/24 hour mode selection.
.equ  _RTCPERSIAN,  (1 << 1)      @ Persion calendar.
.equ  _RTCNEGPPM,   (1 << 4)      @ Negative PPM Correction.
.equ  _RTCSCCMSK,   (0X7F << 8)   @ Slow Clock Correction bit-mask.
.equ  _RTCHIGHPPM,  (1 << 15)     @ High PPM correction.
.equ  _RTCOUT0MSK,  (0X07 << 16)  @ Output Source Selection 0 bit-mask.
.equ  _RTCOUT0NONE, (0 << 16)     @ No waveform (stuck at 0).
.equ  _RTCOUT01,    (1 << 16)     @ 1 Hz square wave.
.equ  _RTCOUT032,   (2 << 16)     @ 32 Hz swuare wave.
.equ  _RTCOUT064,   (3 << 16)     @ 64 Hz square wave.
.equ  _RTCOUT0512,  (4 << 16)     @ 512 Hz square wave.
.equ  _RTCOUT0TOGL, (5 << 16)     @ Output toggles when alarm flag rises.
.equ  _RTCOUT0FLAG, (6 << 16)     @ Output is a copy of the alarm flag.
.equ  _RTCOUT0PLSE, (7 << 16)     @ Duty cycle programmable pulse.
.equ  _RTCOUT1MSK,  (0X07 << 20)  @ Output Source Selection 1 bit-mask.
.equ  _RTCOUT11,    (1 << 20)     @ 1 Hz square wave.
.equ  _RTCOUT132,   (2 << 20)     @ 32 Hz swuare wave.
.equ  _RTCOUT164,   (3 << 20)     @ 64 Hz square wave.
.equ  _RTCOUT1512,  (4 << 20)     @ 512 Hz square wave.
.equ  _RTCOUT1TOGL, (5 << 20)     @ Output toggles when alarm flag rises.
.equ  _RTCOUT1FLAG, (6 << 20)     @ Output is a copy of the alarm flag.
.equ  _RTCOUT1PLSE, (7 << 20)     @ Duty cycle programmable pulse.
.equ  _RTCTHIGHMSK, (0X07 << 24)  @ High duration of the output pulse bit-mask.
.equ  _RTCTH32MS,   (0 << 24)     @ 31.2 ms.
.equ  _RTCTH16MS,   (1 << 24)     @ 15.6 ms.
.equ  _RTCTH4MS,    (2 << 24)     @ 3.91 ms.
.equ  _RTCTH976US,  (3 << 24)     @ 976 us.
.equ  _RTCTH488US,  (4 << 24)     @ 488 us.
.equ  _RTCTH122Us,  (5 << 24)     @ 122 us.
.equ  _RTCTH30US,   (6 << 24)     @ 30.5 us.
.equ  _RTCTH15US,   (7 << 24)     @ 15.2 us.
.equ  _RTCTPERMSK,  (0X07 << 28)  @ Period of the pulse bit-mask.
.equ  _RTCTP1S,     (0 << 28)     @ 1 second.
.equ  _RTCTP500MS,  (1 << 28)     @ 500 ms.
.equ  _RTCTP250MS,  (2 << 28)     @ 250 ms.
.equ  _RTCTP125MS,  (3 << 28)     @ 125 ms.
@ RTC_TIMR Time Register.
.equ  _RTCSECMSK,   (0X7F << 0)   @ Current second 00-59 BCD.
.equ  _RTCMINMSK,   (0x7F << 8)   @ Current minute 00-59 BCD.
.equ  _RTCHOURMSK,  (0X3F << 16)  @ Current hour 1-12 | 0-23 BCD.
.equ  _RTCAMPM,     (1 << 22)     @ Ante Meridiem / Post Merediem indicator.
@ RTC_CALR Calendar Register.
.equ  _RTCCENTMSK,  (0X7F << 0)   @ Current century 19-20 | 13-14 BCD.
.equ  _RTCYEARMSK,  (0XFF << 8)   @ Current year 00-99 BCD.
.equ  _RTCMONTHMSK, (0X1F << 16)  @ Current month 1-12 BCD.
.equ  _RTCDAYMSK,   (0X03 << 21)  @ Current cay in week 1-7 BCD.
.equ  _RTCDATEMSK,  (0X3F << 24)  @ Current day in month 01-31 BCD.
@ RTC_TIMALR Time Alarm Register.
.equ  _RTCALRSECEN, (1 << 7)      @ Second Alarm Enable.
.equ  _RTCALRMINEN, (1 << 15)     @ Minute Alarm Enable.
.equ  _RTCALRHREN,  (1 << 23)     @ Hour Alarm Enable.
@ RTC_CALALR Calendar Alarm Register.
.equ  _RTCALRMTHEN, (1 << 23)     @ Month Alarm Enable.
.equ  _RTCALRDATEN, (1 << 31)     @ Date Alarm Enable.
@ RTC_SR Status Register.
.equ  _RTCACKUPD,   (1 << 0)      @ Acknowledge for update.
.equ  _RTCALARM,    (1 << 1)      @ Alarm flag.
.equ  _RTCSEC,      (1 << 2)      @ Second event.
.equ  _RTCTIMEV,    (1 << 3)      @ Time event.
.equ  _RTCCALEV,    (1 << 4)      @ Calendar event.
.equ  _RTCTDERR,    (1 << 5)      @ Time and/or date free running error.
@ RTC_WPMR Write Protection Mode Register.
.equ  _RTCKEY,      0X52544300    @ Write Protection Key (PASSWD).
.equ  _RTCWPEN,     (1 << 0)      @ Write Protection Enable.
@-----------------------------------------------------------------------------
@ SCB System Control Block.
.equ _SCB,      0XE000E000
@-----------------------------------------------------------------------------
@ System Tick Controller.
@-----------------------------------------------------------------------------
@ SysTick Register offsets from group base address.
.equ _STCTRLV,  0X0000  @ Control/Status Register.
.equ _STLOADV,  0X0004  @ Reload Value Register.
.equ _STVALV,   0X0008  @ Current Value Register.
.equ _STCALIBV, 0X000C  @ Calibration Value Register.
@-----------------------------------------------------------------------------
@ SysTick Register definitions.
.equ _SYSTICK,  0XE000E010              @ SysTick register group base address
.equ _STCTRL,   (_SYSTICK + _STCTRLV)   @ SysTick Control/Status Register.
.equ _STLOAD,   (_SYSTICK + _STLOADV)   @ SysTick Reload Value Register.
.equ _STVAL,    (_SYSTICK + _STVALV)    @ SysTick Current Value Register.
.equ _STCALIB,  (_SYSTICK + _STCALIBV)  @ SysTick Calibration Value Register.
@-----------------------------------------------------------------------------
@ SysTick Control/Status Register bit-field definitions.
.equ _COUNTFLAG,0B0000000000000010000000000000000
.equ _CLKSOURCE,0B0000000000000000000000000000100
.equ _TICKINT,  0B0000000000000000000000000000010
.equ _ENABLE,   0B0000000000000000000000000000001
@-----------------------------------------------------------------------------
.equ _ACLTRV,   0X0008  @ Auxillary Control Register offset.
@-----------------------------------------------------------------------------
@ Auxillary Control Register bit-field definitions.
.equ _DISFOLD,        (1 << 2)    @
.equ _FPEXCODIS,      (1 << 10)   @ FPU exception output disable.
.equ _DISRAMODE,      (1 << 11)   @ Dynamic read allocate mode.
.equ _DISITMATBFLUSH, (1 << 12)   @ Disable dynamic read allocate mode.
.equ _DISBTACREAD,    (1 << 13)   @ .
.equ _DISBTALLOC,     (1 << 14)   @ .
.equ _DISCRITAXIRUR,  (1 << 15)   @ .
.equ _DISDYNADD,      (1 << 26)   @ Dynamic Add and SUB instruction resolution.
.equ _DISCRITAXIRUW,  (1 << 27)   @ Disable dynamis allocation of ADD and SUB instructions.
.equ _DISFPUISSOPT,   (1 << 28)   @ Disable critical AXI read-under-write.
@-----------------------------------------------------------------------------
.equ _CPUIDV,   0X0D00  @ CPUID Base Register offset.
.equ _ICSRV,    0X0D04  @ Interrupt Control and State Register offset.
.equ _VTORV,    0X0D08  @ Vector Table Offset Register.
.equ _AIRCRV,   0X0D0C  @ Application Interrupt and Reset Controller.
.equ _SCRV,     0X0D10  @ System Control Register.
.equ _CCRV,     0X0D14  @ Configuration and Control register.
@-----------------------------------------------------------------------------
@ Control and Configuration Control Register bit-field definitions.
.equ _NONBASETHRDENA, (1 << 0)    @ Processor can enter Thread mode anytime.
.equ _USERSETMPEND,   (1 << 1)    @ Indicates how processor enters Thread mode.
.equ _DIV_0_TRP,      (1 << 4)    @ Disable Divide by 0 Trap.
.equ _BFHFNMIGN,      (1 << 8)    @ Disable Data-Bus Faults at Priority 1 & 2.
.equ _STKALIGN,       (1 << 9)    @ Stack alignment is 8-bytes on exception entry.
.equ _DC,             (1 << 16)   @ Enable L1 Data Cache.
.equ _IC,             (1 << 17)   @ Enable L1 Instruction Cache.
.equ _BP,             (1 << 18)   @ Branch Prediction is Enabled.
@-----------------------------------------------------------------------------
.equ _SHPR1V,   0X0D18  @ System Handler Priority Register 1.
.equ _SHPR2V,   0X0D1C  @ System Handler Priority Register 2.
.equ _SHPR3V,   0X0D20  @ System Handler Priority Register 3.
.equ _SHCRSV,   0X0D24  @ System Handler Control and State Register.
.equ _CFSRV,    0X0D28  @ Configurable Fault Status Register.
.equ _MMSRV,    0X0D28  @ MemManage Fault Status Register.
.equ _BFSRV,    0X0D29  @ BusFault Status Register.
.equ _UFSRV,    0X0D2A  @ UsageFault Status Register.
.equ _HFSRV,    0X0D2C  @ HardFault Status Register.
.equ _MMARV,    0X0D34  @ MemManage Fault Address Register.
.equ _AFSRV,    0X0D3C  @ Auxiliary Fault Status Register not implemented.
@-----------------------------------------------------------------------------
@ FPU Floating Point Unit offsets from SCB base address.
.equ _CPACRV,   0X0D88  @ Coprocessor Access Control Register.
.equ _FPCCRV,   0X0F34  @ Floating-point Context Control Register.
.equ _FPCARV,   0X0F38  @ Floating-point Context Address Register.
.equ _FPDSCR,   0X0F3C  @ Floating-point Default Status Control Register.
@-----------------------------------------------------------------------------
@ Coprocessor Access Control Register bit-field definitions.
.equ _FPFULL,   (0X0F << 20)      @ Full (unpriviliged) FPU access.
@-----------------------------------------------------------------------------
@ Cache control.
.equ  _ICIALLUV,      0X0F50      @ Instruction Cache invalidate all.
.equ  _ICIMCAUV,      0X0F58      @ Instruction Cache Invalidate by address.
.equ  _DCIMVACV,      0X0F5C      @ Data Cache Invalidate by address.
.equ  _DCISWV,        0X0F60      @ Data Cache Invalidate by set/way.
.equ  _DCCMVAUV,      0X0F64      @ Data Cache Clean by address.
.equ  _DCCMVACV,      0X0F68      @ Data Cache Clean by address.
.equ  _DCCSWV,        0X0F6C      @ Data Cache Clean by set/way.
.equ  _DCCIMVACV,     0X0F70      @ Data Cache Clean and Invalidate by address.
.equ  _DCCISWV,       0X0F74      @ Data Cache Clean and Invalidate by set/way.
.equ  _BPIALLV,       0X0F78      @ Not Implemented.
@-----------------------------------------------------------------------------
@ NVIC Register offsets from group base address.
.equ  _NVICISER0V,    0X0000      @ Interrupt Set Enable Register 0 offset.
.equ  _NVICISER1V,    0X0004      @ Interrupt Set Enable Register 1 offset.
.equ  _NVICISER2V,    0X0008      @ Interrupt Set Enable Register 2 offset.
.equ  _NVICICER0V,    0X0080      @ Interrupt Clear Enable Register 0 offset.
.equ  _NVICICER1V,    0X0084      @ Interrupt Clear Enable Register 1 offset.
.equ  _NVICICER2V,    0X0088      @ Interrupt Clear Enable Register 2 offset.
.equ  _NVICISPR0V,    0X0100      @ Interrupt Set Pending Register 0 offset.
.equ  _NVICISPR1V,    0X0104      @ Interrupt Set Pending Register 1 offset.
.equ  _NVICISPR2V,    0X0108      @ Interrupt Set Pending Register 2 offset.
.equ  _NVICICPR0V,    0X0180      @ Interrupt Clear Pending Register 0 offset.
.equ  _NVICICPR1V,    0X0184      @ Interrupt Clear Pending Register 1 offset.
.equ  _NVICICPR2V,    0X0188      @ Interrupt Clear Pending Register 2 offset.
.equ  _NVICIABR0V,    0X0200      @ Interrupt Active Bit Register 0 offset.
.equ  _NVICIABR1V,    0X0204      @ Interrupt Active Bit Register 1 offset.
.equ  _NVICIABR2V,    0X0208      @ Interrupt Active Bit Register 2 offset.
.equ  _NVICIPR0V,     0X0300      @ Interrupt Priority Register 0 offset.
.equ  _NVICIPR1V,     0X0304      @ Interrupt Priority Register 1 offset.
.equ  _NVICIPR2V,     0X0308      @ Interrupt Priority Register 2 offset.
.equ  _NVICIPR3V,     0X030C      @ Interrupt Priority Register 3 offset.
.equ  _NVICIPR4V,     0X0310      @ Interrupt Priority Register 4 offset.
.equ  _NVICIPR5V,     0X0314      @ Interrupt Priority Register 5 offset.
.equ  _NVICIPR6V,     0X0318      @ Interrupt Priority Register 6 offset.
.equ  _NVICIPR7V,     0X031C      @ Interrupt Priority Register 7 offset.
.equ  _NVICIPR8V,     0X0320      @ Interrupt Priority Register 8 offset.
.equ  _NVICIPR9V,     0X0324      @ Interrupt Priority Register 9 offset.
.equ  _NVICIPR10V,    0X0328      @ Interrupt Priority Register 10 offset.
.equ  _NVICIPR11V,    0X032C      @ Interrupt Priority Register 11 offset.
.equ  _NVICIPR12V,    0X0330      @ Interrupt Priority Register 12 offset.
.equ  _NVICIPR13V,    0X0334      @ Interrupt Priority Register 13 offset.
.equ  _NVICIPR14V,    0X0338      @ Interrupt Priority Register 14 offset.
.equ  _NVICIPR15V,    0X033C      @ Interrupt Priority Register 15 offset.
.equ  _NVICSTIRV,     0X0E00      @ Software Trigger Interrupt Register.
@-----------------------------------------------------------------------------
@ Nested Vectored Interrupt Controller Register definitions.
.equ  _NVIC,      0XE000E100              @ NVIC Controller group base address.
.equ  _NVICISER0, (_NVIC + _NVICISER0V)   @ Interrupt Set Enable Register.
.equ  _NVICISER1, (_NVIC + _NVICISER1V)   @ Interrupt Set Enable Register.
.equ  _NVICICER0, (_NVIC + _NVICICER0V)   @ Interrupt Clear Enable Register.
.equ  _NVICICER1, (_NVIC + _NVICICER1V)   @ Interrupt Clear Enable Register.
.equ  _NVICISPR0, (_NVIC + _NVICISPR0V)   @ Interrupt Set Pending Register.
.equ  _NVICISPR1, (_NVIC + _NVICISPR1V)   @ Interrupt Set Pending Register.
.equ  _NVICICPR0, (_NVIC + _NVICICPR0V)   @ Interrupt Clear Pending Register.
.equ  _NVICICPR1, (_NVIC + _NVICICPR1V)   @ Interrupt Clear Pending Register.
.equ  _NVICIABR0, (_NVIC + _NVICIABR0V)   @ Interrupt Active Bit Register.
.equ  _NVICIABR1, (_NVIC + _NVICIABR1V)   @ Interrupt Active Bit Register.
.equ  _NVICIPR0,  (_NVIC + _NVICIPR0V)    @ Interrupt Priority Register.
.equ  _NVICIPR1,  (_NVIC + _NVICIPR1V)    @ Interrupt Priority Register.
.equ  _NVICIPR2,  (_NVIC + _NVICIPR2V)    @ Interrupt Priority Register.
.equ  _NVICIPR3,  (_NVIC + _NVICIPR3V)    @ Interrupt Priority Register.
.equ  _NVICIPR4,  (_NVIC + _NVICIPR4V)    @ Interrupt Priority Register.
.equ  _NVICIPR5,  (_NVIC + _NVICIPR5V)    @ Interrupt Priority Register.
.equ  _NVICIPR6,  (_NVIC + _NVICIPR6V)    @ Interrupt Priority Register.
.equ  _NVICIPR7,  (_NVIC + _NVICIPR7V)    @ Interrupt Priority Register.
.equ  _NVICSTIR,  (_NVIC + _NVICSTIRV)    @ Software Trigger Interrupt.
@-----------------------------------------------------------------------------
@ SAM3X8E NVIC Peripheral Identifier Instance definitions.
.equ  _PID_SUPC,         0    @ Supply Controller.
.equ  _PID_RSTC,         1    @ Reset Controller.
.equ  _PID_RTC,          2    @ Real-Time Clock.
.equ  _PID_RTT,          3    @ Real-Time Timer.
.equ  _PID_WDT,          4    @ Watchdog Timer.
.equ  _PID_PMC,          5    @ Power Management Controller.
.equ  _PID_EFC,          6    @ Enhanced Embedded Flash Controller.
.equ  _PID_UART0,        7    @ Universal Asynchronous Receiver Transmitter.
.equ  _PID_UART1,        8    @ Universal Asynchronous Receiver Transmitter.
.equ  _PID_SMC,          9    @ Static Memory Controller.
.equ  _PID_PIOA,        10    @ Parallel I/O Controller A.
.equ  _PID_PIOB,        11    @ Parallel I/O Controller B.
.equ  _PID_PIOC,        12    @ Parallel I/O Controller C.
.equ  _PID_USART0,      13    @ Universal Synchronous/Asynchronous Receiver/Transmitter 0.
.equ  _PID_USART1,      14    @ Universal Synchronous/Asynchronous Receiver/Transmitter 1.
.equ  _PID_USART2,      15    @ Universal Synchronous/Asynchronous Receiver/Transmitter 2.
.equ  _PID_PIOD,        16    @ Parallel I/O Controller D.
.equ  _PID_PIOE,        17    @ Parallel I/O Controller E.
.equ  _PID_HSMCI,       18    @ High Speed Multimedia Card Interface.
.equ  _PID_TWI0,        19    @ Two-Wire Interface 0.
.equ  _PID_TWI1,        20    @ Two-Wire Interface 1.
.equ  _PID_SPI0,        21    @ Serial Peripheral Interface 0.
.equ  _PID_SSC,         22    @ Synchronous Serial Controller.
.equ  _PID_TC00,        23    @ Timer Counter Channel 0.
.equ  _PID_TC01,        24    @ Timer Counter Channel 1.
.equ  _PID_TC02,        25    @ Timer Counter Channel 2.
.equ  _PID_TC10,        26    @ Timer Counter Channel 3.
.equ  _PID_TC11,        27    @ Timer Counter Channel 4.
.equ  _PID_TC12,        28    @ Timer Counter Channel 5.
.equ  _PID_AFEC0,       29    @ Analog Front-End Controller 0.
.equ  _PID_DACC,        30    @ Digital->Analog Converter Controller.
.equ  _PID_PWM0,        31    @ Pulse Width Modulator Controller 0.
.equ  _PID_ICM,         32    @ Integrity Check Monitor.
.equ  _PID_ACC,         33    @ Analog Comparator Controller.
.equ  _PID_USBHS,       34    @ USB Host/Device Controller.
.equ  _PID_MCAN00,      35    @ CAN 0 IRQ 0.
.equ  _PID_MCAN01,      36    @ CAN 0 IRQ 1.
.equ  _PID_MCAN10,      37    @ CAN 1 IRQ 0.
.equ  _PID_MCAN11,      38    @ CAN 1 IRQ 1.
.equ  _PID_GMAC,        39    @ Ethernet Controller.
.equ  _PID_AFEC1,       40    @ Analog Front-End Controller 1.
.equ  _PID_TWI2,        41    @ Two-Wire Interface 2.
.equ  _PID_SPI1,        42    @ Serial Peripheral Interface 1.
.equ  _PID_QSPI,        43    @ Quad I/O Serial Peripheral Interface
.equ  _PID_UART2,       44    @ Universal Asynchronous Receiver/Transmitter 2.
.equ  _PID_UART3,       45    @ Universal Asynchronous Receiver/Transmitter 2.
.equ  _PID_UART4,       46    @ Universal Asynchronous Receiver/Transmitter 2.
.equ  _PID_TC20,        47    @ Timer Counter Channel 6.
.equ  _PID_TC21,        48    @ Timer Counter Channel 7.
.equ  _PID_TC22,        49    @ Timer Counter Channel 8.
.equ  _PID_TC30,        50    @ Timer Counter Channel 9.
.equ  _PID_TC31,        51    @ Timer Counter Channel 10.
.equ  _PID_TC32,        52    @ Timer Counter Channel 11.
.equ  _PID_MLB0,        53    @ MediaLB IRQ 0.
.equ  _PID_MLB1,        54    @ MediaLB IRQ 1.
.equ  _PID_NONE,        55    @ Unused.
.equ  _PID_AES,         56    @ Advanced Encryption Standard.
.equ  _PID_TRNG,        57    @ True Random Number Generator.
.equ  _PID_XDMAC,       58    @ DMA Controller.
.equ  _PID_ISI,         59    @ Image Sensor Interface.
.equ  _PID_PWM1,        60    @ Pulse Width Modulator Controller 1.
.equ  _PID_FPU,         61    @ Floating Point Unit OFC/UFC/IOC/DZC/IDC bits.
.equ  _PID_SDRAMC,      62    @ Synchronous Dynamic RAM Controller.
.equ  _PID_RSWDT,       63    @ Reinforced Safety Watchdog Timer.
.equ  _PID_CCW,         64    @ ARM Cache ECC Warning.
.equ  _PID_CCF,         65    @ ARM Cache ECC Fault.
.equ  _PID_GMACQ1,      66    @ GMAC Queue 1 Interrupt.
.equ  _PID_GMACQ2,      67    @ GMAC Queue 2 Interrupt.
.equ  _PID_FPUIXC,      68    @ FPU IXC Exception.
.equ  _PID_I2SC0,       69    @ Inter-IC Sound Controller 0.
.equ  _PID_I2SC1,       70    @ Inter-IC Sound Controller 1.
.equ  _PID_GMACQ3,      71    @ GMAC Queue 1 Interrupt.
.equ  _PID_GMACQ4,      72    @ GMAC Queue 2 Interrupt.
.equ  _PID_GMACQ5,      73    @ GMAC Queue 2 Interrupt.
@-----------------------------------------------------------------------------
@ SAME70 SBC Peripheral Identifier Instance definitions.
@-----------------------------------------------------------------------------
@ end: atsame70.i       
