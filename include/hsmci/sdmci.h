//-----------------------------------------------------------------------------
// file: sdmci.h
//
// SmegARM ATSAME70 HSMCI module interface definition.
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

// HSMCI High-Speed Multimedia Card Interface register definitions.
struct _HSMCI {
  uint32_t  cr;           /* 0X0000 - Control Register. */
  uint32_t  mr;           /* 0X0004 - Mode Register. */
  uint32_t  dtor;         /* 0X0008 - Data TimeOut Register. */
  uint32_t  sdcr;         /* 0X000C - SDCard/SDIO Register. */
  uint32_t  argr;         /* 0X0010 - Argument Register. */
  uint32_t  cmdr;         /* 0X0014 - Command Register. */
  uint32_t  blkr;         /* 0X0018 - Block Register. */
  uint32_t  cstor;        /* 0X001C - Completion Signal TimeOut Register, */
  uint32_t  rspr[4];      /* 0X0020 - Response Register. */
  uint32_t  rdr;          /* 0X0030 - Receive Data Register. */
  uint32_t  tdr;          /* 0X0034 - Transmit Data Register. */
  uint32_t  rsvd1[2];     /* Reserved. */
  uint32_t  sr;           /* 0X0040 - Status Register. */
  uint32_t  ier;          /* 0X0044 - Interrupt Enable Register. */
  uint32_t  idr;          /* 0X0048 - Interrupt Disable Register. */
  uint32_t  imr;          /* 0X004C - Interrupt Mask Register. */
  uint32_t  dma;          /* 0X0050 - DMA Configuration Register. */
  uint32_t  cfg;          /* 0X0054 - Configuration Register. */
  uint32_t  rsvd2[35];    /* Reserved. */
  uint32_t  wpmr;         /* 0X00E4 - Write Protection Mode Register. */
  uint32_t  wpsr;         /* 0X00E8 - Write Protection Status Register. */
  uint32_t  rsvd3[69];    /* Reserved. */
  uint32_t  fifo;         /* 0X0200-0X0600 - FIFO Aperture. */
};

// HSMCI_CR Control Register bit-field definitions.
#define HSMCI_SWRST           (1 << 7)    /* Software Reset. */
#define HSMCI_PWSDIS          (1 << 3)    /* Power Save Mode Disable. */
#define HSMCI_PWSEN           (1 << 2)    /* Power Save Mode Enable. */
#define HSMCI_MCIDIS          (1 << 1)    /* MultiMedia Interface Disable. */
#define HSMCI_MCIEN           (1 << 0)    /* MultiMedia Interface Enable. */

// HSMCI_MR Mode Register bit-fied definitions.
#define HSMCI_CLKODD          (1 << 16)   /* Clock Divider is Odd. */
#define HSMCI_PADV00          (0 << 14)   /* Use write transfer padding value 0X00. */
#define HSMCI_PADVFF          (1 << 14)   /* Use write transfer padding value 0XFF. */
#define HSMCI_FBYTE           (1 << 13)   /* Force Byt Transfer. */
#define HSMCI_WRPROOF         (1 << 12)   /* Write Proof Enable. */
#define HSMCI_RDPROOF         (1 << 11)   /* Read Proof Enable. */
#define HSMCI_PWSDIVPOS       8           /* Power Saving Divider. */
#define HSMCI_PWSDIVMSK       (0X03 << HSMCI_PWSDIVPOS)
#define HSMCI_PWSDIV(d)       (((d) << HSMCI_PWSDIVPOS) & HSMCI_PWRDIVMSK)
#define HSMCI_CLKDIVMSK       (0XFF << 0) /* Clock Divider Mask. */
#define HSMCI_CLKDIV(d)       ((d) & HSMCI_CLKDIVMSK)

// HSMCI_DTOR/CSTOR TimeOut Register bit-field definitions.
#define HSMCI_TOMULPOS        (4)         /* Data TimeOut Multiplier. */
#define HSMCI_TOMULMSK        (0X07 << HSMCI_TOMULPOS)
#define HSMCI_TOMUL(t)        (((t) << HSMCI_TOMULPOS) & HSMCI_TOMULMSK)
#define HSMCI_TOMUL1          (0 << 4)    /* TOCYC * 1. */
#define HSMCI_TOMUL16         (1 << 4)    /* TOCYC * 16. */
#define HSMCI_TOMUL128        (2 << 4)    /* TOCYC * 128. */
#define HSMCI_TOMUL256        (3 << 4)    /* TOCYC * 256. */
#define HSMCI_TOMUL1024       (4 << 4)    /* TOCYC * 1024. */
#define HSMCI_TOMUL4096       (5 << 4)    /* TOCYC * 4096. */
#define HSMCI_TOMUL65536      (6 << 4)    /* TOCYC * 65536. */
#define HSMCI_TOMUL1048576    (7 << 4)    /* TOCYC * 1048576. */
#define HSMCI_TOCYCPOS        (0)         /* Data TimeOut Cycle Number. */
#define HSMCI_TOCYCMSK        (0X0F << HSMCI_TOCYCPOS)
#define HSMCI_TOCYC(t)        (((t) << HSMCI_TOCYCPOS) & HSMCI_TOCYCMSK)

// HSMCI_SDCR SDCard/SDIO Register bit-field definitions.
#define HSMCI_SDCBUS1         (0 << 6)    /* Bus Width 1-bit. */
#define HSMCI_SDCBUS4         (2 << 6)    /* Bus Width 4-bits. */
#define HSMCI_SDCBUS8         (3 << 6)    /* Bus Width 8-bits. */
#define HSMCI_SDCSELA         (0 << 0)    /* Slot A Select. */

// HSMCI_CMDR Command Register bit-field definitions.
#define HSMCI_BOOT_ACK        (1 << 27)   /* Boot Operation Acknowledge. */
#define HSMCI_ATACS           (1 << 26)   /* ATA with Command Completion Signal. */
#define HSMCI_IOSPCMDMSK      (0X3 << 24) /* SDIO Special Command bit-mask. */
#define HSMCI_IOSPCMD_STD     (0 << 24)   /* Not an SDIO Special Command. */
#define HSMCI_IOSPCMD_SUSPEND (1 << 24)   /* SDIO Suspend Command */
#define HSMCI_IOSPCMD_RESUME  (2 << 24)   /* SDIO Resume Command */
#define HSMCI_TRTYPEMSK       (0X7 << 19) /* Transfer Type bit-mask. */
#define HSMCI_TRTYPE_SINGLE   (0 << 19)   /* MMC/SD Card Single Block. */
#define HSMCI_TRTYPE_MULTIPLE (1 << 19)   /* MMC/SD Card Multiple Block. */
#define HSMCI_TRTYPE_STREAM   (2 << 19)   /* MMC Stream. */
#define HSMCI_TRTYPE_BYTE     (4 << 19)   /* SDIO Byte. */
#define HSMCI_TRTYPE_BLOCK    (5 << 19)   /* SDIO Block. */
#define HSMCI_TRDIR_WRITE     (0 << 18)   /* Write operation. */
#define HSMCI_TRDIR_READ      (1 << 18)   /* Read operation. */
#define HSMCI_TRCMDMSK        (0X3 << 16) /* Transfer Command bit-mask. */
#define HSMCI_TRCMD_NODATA    (0 << 16)   /* No Data Transfer. */
#define HSMCI_TRCMD_STARTDATA (1 << 16)   /* Start Data Transfer. */
#define HSMCI_TRCMD_STOPDATA  (2 << 16)   /* Stop Data Transfer. */
#define HSMCI_MAXLAT5         (0 << 12)   /* 5-cycle Max Latency. */
#define HSMCI_MAXLAT64        (1 << 12)   /* 64-cycle Max Latency. */
#define HSMCI_OPDCMD          (1 << 11)   /* Open Drain CMD. */
#define HSMCI_SPCMDMSK        (0X7 << 8)  /* Special Command bit-mask. */
#define HSMCI_SPCMD_STD       (0 << 8)    /* Not a special CMD. */
#define HSMCI_SPCMD_INIT      (1 << 8)    /* Initialization CMD */
#define HSMCI_SPCMD_SYNC      (2 << 8)    /* Synchronized CMD. */
#define HSMCI_SPCMD_CE_ATA    (3 << 8)    /* CE_ATA Completion Signal disable CMD. */
#define HSMCI_SPCMD_IT_CMD    (4 << 8)    /* Interrupt CMD. */
#define HSMCI_SPCMD_IT_RESP   (5 << 8)    /* Interrupt Response CMD. */
#define HSMCI_SPCMD_BOR       (6 << 8)    /* Boot Operation Request CMD. */
#define HSMCI_SPCMD_EBO       (7 << 8)    /* End Boot Opration CMD. */
#define HSMCI_RSPTYPMSK       (0X3 << 6)  /* Response Type bit-mask. */
#define HSMCI_RSPTYP_NORESP   (0 << 6)    /* No Response. */
#define HSMCI_RSPTYP_48BIT    (1 << 6)    /* 48-bit Response. */
#define HSMCI_RSPTYP_136BIT   (2 << 6)    /* 136-bit Response. */
#define HSMCI_RSPTYP_R1B      (3 << 6)    /* R1B Response Type. */
#define HSMCI_CMDNBPOS        (0)         /* Command Number. */
#define HSMCI_CMDNBMSK        (0X3F << HSMCI_CMDNBPOS)
#define HSMCI_CMDNB(c)        (((c) << HSMCI_CMDNBPOS) & HSMCI_CMDNBMSK)

// HSMCI_BLKR Block Register bit-field definitions.
#define HSMCI_BLKLENPOS       (16)        /* Data Block Length. */
#define HSMCI_BLKLENMSK       (0XFFFF << HSMCI_BLKLENPOS)
#define HSMCI_BLKLEN(l)       (((l) << HSMCI_BLKLENPOS) & HSMCI_BLKLENMSK)
#define HSMCI_BCNTPOS         (0)         /* MMC/SDIO Block Count - SDIO Byte Count. */
#define HSMCI_BCNTMSK         (0XFFFF << HSMCI_BCNTPOS)
#define HSMCI_BCNT(c)         (((c) << HSMCI_BCNTPOS) & HSMCI_BCNTMSK)

// HSMCI_SR Status Register bit-field definitions.
#define HSMCI_UNRE            (1 << 31)   /* Underrun. */
#define HSMCI_OVRE            (1 << 30)   /* Overrun. */
#define HSMCI_ACKRCVE         (1 << 29)   /* Boot Operation Acknowledge Error. */
#define HSMCI_ACKRCV          (1 << 28)   /* Boot Opration Acknowledge Received. */
#define HSMCI_XFRDONE         (1 << 27)   /* Transfer Done. */
#define HSMCI_FIFOEMPTY       (1 << 26)   /* FIFO Empty. */
#define HSMCI_BLKOVRE         (1 << 24)   /* DMA Block Overrun Error. */
#define HSMCI_CSTOE           (1 << 23)   /* Completion Signal TimeOut Error. */
#define HSMCI_DTOE            (1 << 22)   /* Data TimeOut Error. */
#define HSMCI_DCRCE           (1 << 21)   /* Data CRC Error. */
#define HSMCI_RTOE            (1 << 20)   /* Response TimeOut Error. */
#define HSMCI_RENDE           (1 << 19)   /* Response End Bit Error. */
#define HSMCI_RCRCE           (1 << 18)   /* Response CRC Error. */
#define HSMCI_RDIRE           (1 << 17)   /* Response Direction Error. */
#define HSMCI_RINDE           (1 << 16)   /* Response Index Error. */
#define HSMCI_CSRCV           (1 << 13)   /* CE_ATA COmpletion Signal Received. */
#define HSMCI_SDIOWAIT        (1 << 12)   /* SDIO Read Wait Operation State. */
#define HSMCI_SDIOIRQA        (1 << 8)    /* SDIO Interrupt for Slot A. */
#define HSMCI_NOTBUSY         (1 << 5)    /* HSMCI Not Busy. */
#define HSMCI_DTIP            (1 << 4)    /* Data Transfer in Progress. */
#define HSMCI_BLKE            (1 << 3)    /* Data Block Ended. */
#define HSMCI_TXRDY           (1 << 2)    /* Transmit Ready. */
#define HSMCI_RXRDY           (1 << 1)    /* Receiver Ready. */
#define HSMCI_CMDRDY          (1 << 0)    /* Command Ready. */

// HSMCI_DMA DMA Configuration Register bit-field definitions.
#define HSMCI_DMAEN           (1 << 8)    /* DMA Hardware Handshaking Enable. */
#define HSMCI_CHKSIZE1        (0 << 4)    /* 1 data available. */
#define HSMCI_CHKSIZE2        (1 << 4)    /* 2 data available. */
#define HSMCI_CHKSIZE4        (2 << 4)    /* 4 data available. */
#define HSMCI_CHKSIZE8        (3 << 4)    /* 8 data available. */
#define HSMCI_CHKSIZE16       (4 << 4)    /* 16 data available. */

// HSMCI_CFG Configuration Register bit-field definitions.
#define HSMCI_LSYNC           (1 << 12)   /* Synchronization on the last block. */
#define HSMCI_HSMODE          (1 << 8)    /* High-Speed Mode. */
#define HSMCI_FERRCTRL        (1 << 4)    /* Flow Error Flag Reset Control. */
#define HSMCI_FIFOMODE        (1 << 0)    /* HSMCI Internal FIFO Control Mode. */

// HSMCI_WPMR Write Protection Mode Register bit-field definitions.
#define HSMCI_WPKEY           (0X3D434900)/* Write Protection Key. */
#define HSMCI_WPEN            (1 << 0)    /* Write Protection Enable. */

#define HSMCI ((struct _HSMCI*)0X40000000)

//-----------------------------------------------------------------------------

#define HSMCI_DMA_BLOCKSZ	  (512)

// Card Versions.
#define SD_CSD_VER_UNKNOWN  3           /* Currently Undefined (may change). */
#define CARD_VER_UNKNOWN    (0)         /* Unknown card version. */
#define CARD_VER_SD_1_0     (0x10)      /* SD version 1.0 and 1.01. */
#define CARD_VER_SD_1_10    (0x1A)      /* SD version 1.10. */
#define CARD_VER_SD_2_0     (0X20)      /* SD version 2.00. */
#define CARD_VER_SD_3_0     (0X30)      /* SD version 3.0X. */
#define CARD_VER_MMC_1_2    (0x12)      /* MMC version 1.2. */
#define CARD_VER_MMC_1_4    (0x14)      /* MMC version 1.4. */
#define CARD_VER_MMC_2_2    (0x22)      /* MMC version 2.2. */
#define CARD_VER_MMC_3      (0x30)      /* MMC version 3.0. */
#define CARD_VER_MMC_4      (0x40)      /* MMC version 4.0. */

// Card Types.
#define CARD_TYPE_UNKNOWN   (0)         /* Unknown type card. */
#define CARD_TYPE_SD        (1 << 0)    /* SD card. */
#define CARD_TYPE_MMC       (1 << 1)    /* MMC card. */
#define CARD_TYPE_SDIO      (1 << 2)    /* SDIO card. */
#define CARD_TYPE_HC        (1 << 3)    /* High capacity card. */
// SD combo card (io + memory).
#define CARD_TYPE_SD_COMBO  (CARD_TYPE_SD | CARD_TYPE_SDIO)

// Set of flags to define a reponse type.
#define SDMMC_CMD_NO_RESP   (HSMCI_SPCMD_STD | HSMCI_RSPTYP_NORESP)
#define SDMMC_CMD_R1        (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_48BIT)
#define SDMMC_CMD_R1B       (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_R1B)
#define SDMMC_CMD_R2        (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_136BIT)
#define SDMMC_CMD_R3        (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_48BIT)    /* Should have no CRC. */
#define SDMMC_CMD_R4        (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_48BIT)    /* Should have no CRC. */
#define SDMMC_CMD_R5        (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_48BIT)
#define SDMMC_CMD_R6        (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_48BIT)
#define SDMMC_CMD_R7        (HSMCI_MAXLAT64 | HSMCI_SPCMD_STD | HSMCI_RSPTYP_48BIT)

// Hardware Abstraction.
#define SDMMC_CMD_OPENDRAIN       (HSMCI_OPDCMD)
#define SDMMC_CMD_SINGLE_BLOCK    (HSMCI_TRTYPE_SINGLE)
#define SDMMC_CMD_MULTI_BLOCK     (HSMCI_TRTYPE_MULTIPLE)
#define SDMMC_CMD_SDIO_STREAM     (HSMCI_TRTYPE_STREAM)
#define SDMMC_CMD_SDIO_BLOCK      (HSMCI_TRTYPE_BLOCK)
#define SDMMC_CMD_SDIO_BYTE       (HSMCI_TRTYPE_BYTE)
#define SDMMC_CMD_READ            (HSMCI_TRDIR_READ | HSMCI_TRCMD_STARTDATA)
#define SDMMC_CMD_WRITE           (HSMCI_TRDIR_WRITE | HSMCI_TRCMD_STARTDATA)

// --- Basic commands and read-stream command (class 0 and class 1) ---

// Cmd0(bc): Reset all cards to idle state.
#define SDMMC_SPI_CMD0_GO_IDLE_STATE     (0 | SDMMC_CMD_R1)
#define SDMMC_MCI_CMD0_GO_IDLE_STATE     (0 | SDMMC_CMD_NO_RESP | SDMMC_CMD_OPENDRAIN)
// MMC Cmd1(bcr, R3): Ask the card to send its Operating Conditions.
#define MMC_SPI_CMD1_SEND_OP_COND        (1 | SDMMC_CMD_R1)
#define MMC_MCI_CMD1_SEND_OP_COND        (1 | SDMMC_CMD_R3 | SDMMC_CMD_OPENDRAIN)
// Cmd2(bcr, R2): Ask the card to send its CID number (stuff but arg 0 used).
#define SDMMC_CMD2_ALL_SEND_CID          (2 | SDMMC_CMD_R2 | SDMMC_CMD_OPENDRAIN)
// SD Cmd3(bcr, R6): Ask the card to publish a new relative address (RCA).
#define SD_CMD3_SEND_RELATIVE_ADDR       (3 | SDMMC_CMD_R6 | SDMMC_CMD_OPENDRAIN)
// MMC Cmd3(ac, R1): Assigns relative address to the card.
#define MMC_CMD3_SET_RELATIVE_ADDR       (3 | SDMMC_CMD_R1)
// Cmd4(bc): Program the DSR of all cards (MCI only).
#define SDMMC_CMD4_SET_DSR               (4 | SDMMC_CMD_NO_RESP)
// MMC Cmd5(ac, R1b): Toggle the card between Sleep state and Standby state.
#define MMC_CMD5_SLEEP_AWAKE             (5 | SDMMC_CMD_R1B)
// Cmd7(ac, R1/R1b): Select/Deselect card.
// For SD: R1b only from the selected card.
// For MMC: R1 while selecting from Stand-By State to Transfer State;
//          R1b while selecting from Disconnected State to Programming State.
#define SDMMC_CMD7_SELECT_CARD_CMD       (7 | SDMMC_CMD_R1B)
#define SDMMC_CMD7_DESELECT_CARD_CMD     (7 | SDMMC_CMD_R1)
// MMC Cmd8(adtc, R1): Send EXT_CSD register as a block of data.
#define MMC_CMD8_SEND_EXT_CSD            (8 | SDMMC_CMD_R1 | SDMMC_CMD_READ | SDMMC_CMD_SINGLE_BLOCK)
// SD Cmd8(bcr, R7) : Send SD Memory Card interface condition.
#define SD_CMD8_SEND_IF_COND             (8 | SDMMC_CMD_R7 | SDMMC_CMD_OPENDRAIN)
// Cmd9 SPI (R1): Addressed card sends its card-specific data (CSD).
#define SDMMC_SPI_CMD9_SEND_CSD          (9 | SDMMC_CMD_R1 | SDMMC_CMD_READ | SDMMC_CMD_SINGLE_BLOCK)
// Cmd9 MCI (ac, R2): Addressed card sends its card-specific data (CSD).
#define SDMMC_MCI_CMD9_SEND_CSD          (9 | SDMMC_CMD_R2)
// Cmd10(ac, R2): Addressed card sends its card identification (CID).
#define SDMMC_CMD10_SEND_CID             (10 | SDMMC_CMD_R2)
// MMC Cmd11(adtc, R1): Read data stream from the card, starting at the given
//  address, until a STOP_TRANSMISSION follows.
#define MMC_CMD11_READ_DAT_UNTIL_STOP    (11 | SDMMC_CMD_R1)
// SD Cmd11 MCI (ac, R1): Voltage switching.
#define SD_CMD11_READ_DAT_UNTIL_STOP     (11 | SDMMC_CMD_R1)
// Cmd12(ac, R1b): Force the card to stop transmission.
#define SDMMC_CMD12_STOP_TRANSMISSION    (12 | SDMMC_CMD_R1B)
// Cmd13(R2): Addressed card sends its status register.
#define SDMMC_SPI_CMD13_SEND_STATUS      (13 | SDMMC_CMD_R2)
// Cmd13(ac, R1): Addressed card sends its status register.
#define SDMMC_MCI_CMD13_SEND_STATUS      (13 | SDMMC_CMD_R1)
// MMC Cmd14(adtc, R1): Read the reversed bus testing data pattern from a card.
#define MMC_CMD14_BUSTEST_R              (14 | SDMMC_CMD_R1)
// Cmd15(ac): Send an addressed card into the Inactive State.
// Note: It is a ac cmd, but it must be send like bc cmd to open drain
#define SDMMC_CMD15_GO_INACTIVE_STATE    (15 | SDMMC_CMD_NO_RESP | SDMMC_CMD_OPENDRAIN)
// MMC Cmd19(adtc, R1): Send the bus test data pattern.
#define MMC_CMD19_BUSTEST_W              (19 | SDMMC_CMD_R1)
// Cmd58(R3): Reads the OCR register of a card.
#define SDMMC_SPI_CMD58_READ_OCR         (58 | SDMMC_CMD_R3)
// Cmd59(R1): Turns the CRC option on or off.
#define SDMMC_SPI_CMD59_CRC_ON_OFF       (59 | SDMMC_CMD_R1)

// --- Block-oriented read commands (class 2) ---

// Cmd16(ac, R1): Set the block length (in bytes).
#define SDMMC_CMD16_SET_BLOCKLEN         (16 | SDMMC_CMD_R1)
// Cmd17(adtc, R1): Read single block.
#define SDMMC_CMD17_READ_SINGLE_BLOCK    (17 | SDMMC_CMD_R1 | SDMMC_CMD_READ | SDMMC_CMD_SINGLE_BLOCK)
// Cmd18(adtc, R1): Read multiple block.
#define SDMMC_CMD18_READ_MULTIPLE_BLOCK  (18 | SDMMC_CMD_R1 | SDMMC_CMD_READ | SDMMC_CMD_MULTI_BLOCK)

// --- Sequential write commands (class 3) ---

// MMC Cmd20(adtc, R1): Write a data stream from the host, starting at the
//  given address, until a STOP_TRANSMISSION follows.
#define MMC_CMD20_WRITE_DAT_UNTIL_STOP   (20 | SDMMC_CMD_R1)

// --- Block-oriented write commands (class 4) ---

// MMC Cmd23(ac, R1): Set block count.
#define MMC_CMD23_SET_BLOCK_COUNT        (23 | SDMMC_CMD_R1)
// Cmd24(adtc, R1): Write block.
#define SDMMC_CMD24_WRITE_BLOCK          (24 | SDMMC_CMD_R1 | SDMMC_CMD_WRITE | SDMMC_CMD_SINGLE_BLOCK)
// Cmd25(adtc, R1): Write multiple block.
#define SDMMC_CMD25_WRITE_MULTIPLE_BLOCK (25 | SDMMC_CMD_R1 | SDMMC_CMD_WRITE | SDMMC_CMD_MULTI_BLOCK)
// MMC Cmd26(adtc, R1): Programming of the card identification register.
#define MMC_CMD26_PROGRAM_CID            (26 | SDMMC_CMD_R1)
// Cmd27(adtc, R1): Programming of the programmable bits of the CSD.
#define SDMMC_CMD27_PROGRAM_CSD          (27 | SDMMC_CMD_R1)

// --- Erase commands  (class 5) ---

// SD Cmd32(ac, R1):
#define SD_CMD32_ERASE_WR_BLK_START      (32 | SDMMC_CMD_R1)
// SD Cmd33(ac, R1):
#define SD_CMD33_ERASE_WR_BLK_END        (33 | SDMMC_CMD_R1)
// MMC Cmd35(ac, R1):
#define MMC_CMD35_ERASE_GROUP_START      (35 | SDMMC_CMD_R1)
// MMC Cmd36(ac, R1):
#define MMC_CMD36_ERASE_GROUP_END        (36 | SDMMC_CMD_R1)
// Cmd38(ac, R1B):
#define SDMMC_CMD38_ERASE                (38 | SDMMC_CMD_R1B)

// --- Block Oriented Write Protection Commands (class 6) ---

// Cmd28(ac, R1b): Set write protection.
#define SDMMC_CMD28_SET_WRITE_PROT       (28 | SDMMC_CMD_R1B)
// Cmd29(ac, R1b): Clr write protection.
#define SDMMC_CMD29_CLR_WRITE_PROT       (29 | SDMMC_CMD_R1B)
// Cmd30(adtc, R1b): Send write protection.
#define SDMMC_CMD30_SEND_WRITE_PROT      (30 | SDMMC_CMD_R1)

// --- Lock Card (class 7) ---

// Cmd42(adtc, R1): Used to set/reset the password or lock/unlock the card.
#define SDMMC_CMD42_LOCK_UNLOCK          (42 | SDMMC_CMD_R1)

// --- Application-specific commands (class 8) ---

// Cmd55(ac, R1): Indicate to the card that the next command is an
//  application specific command rather than a standard command.
#define SDMMC_CMD55_APP_CMD              (55 | SDMMC_CMD_R1)
// Cmd 56(adtc, R1): Used either to transfer a data block to the card or to get
//  a data block from the card for general purpose/application specific commands.
#define SDMMC_CMD56_GEN_CMD              (56 | SDMMC_CMD_R1)
// MMC Cmd6(ac, R1b) : Switche the mode of operation of the selected card
//  or modifies the EXT_CSD registers.
#define MMC_CMD6_SWITCH                  (6 | SDMMC_CMD_R1B)
// SD Cmd6(adtc, R1) : Check switchable function (mode 0)
//  and switch card function (mode 1).
#define SD_CMD6_SWITCH_FUNC              (6 | SDMMC_CMD_R1 | SDMMC_CMD_READ | SDMMC_CMD_SINGLE_BLOCK)
// ACMD6(ac, R1): Define the data bus width.
#define SD_ACMD6_SET_BUS_WIDTH           (6 | SDMMC_CMD_R1)
// ACMD13(adtc, R1): Send the SD Status.
#define SD_ACMD13_SD_STATUS              (13 | SDMMC_CMD_R1)
// ACMD22(adtc, R1): Send the number of the written (with-out errors) write
//  blocks.
#define SD_ACMD22_SEND_NUM_WR_BLOCKS     (22 | SDMMC_CMD_R1)
// ACMD23(ac, R1): Set the number of write blocks to be pre-erased before
// writing.
#define SD_ACMD23_SET_WR_BLK_ERASE_COUNT (23 | SDMMC_CMD_R1)
// ACMD41(bcr, R3): Send host capacity support information (HCS) and asks the
//  accessed card to send its operating condition register (OCR) content
//  in the response.
#define SD_MCI_ACMD41_SD_SEND_OP_COND    (41 | SDMMC_CMD_R3 | SDMMC_CMD_OPENDRAIN)
// ACMD41(R1): Send host capacity support information (HCS) and activates the
//  card's initilization process.
#define SD_SPI_ACMD41_SD_SEND_OP_COND    (41 | SDMMC_CMD_R1)
// ACMD42(ac, R1): Connect[1]/Disconnect[0] the 50 KOhm pull-up resistor on
//  CD/DAT3 (pin 1) of the card.
#define SD_ACMD42_SET_CLR_CARD_DETECT    (42 | SDMMC_CMD_R1)
// ACMD51(adtc, R1): Read the SD Configuration Register (SCR).
#define SD_ACMD51_SEND_SCR               (51 | SDMMC_CMD_R1 | SDMMC_CMD_READ | SDMMC_CMD_SINGLE_BLOCK)

// --- I/O mode commands (class 9) ---

// MMC Cmd39(ac, R4): Used to write and read 8 bit (register) data fields.
#define MMC_CMD39_FAST_IO                (39 | SDMMC_CMD_R4)
// MMC Cmd40(bcr, R5): Set the system into interrupt mode.
#define MMC_CMD40_GO_IRQ_STATE           (40 | SDMMC_CMD_R5 | SDMMC_CMD_OPENDRAIN)
// SDIO Cmd5(R4): Send operation condition.
#define SDIO_CMD5_SEND_OP_COND           (5 | SDMMC_CMD_R4 | SDMMC_CMD_OPENDRAIN)
/// SDIO CMD52(R5): Direct IO read/write.
#define SDIO_CMD52_IO_RW_DIRECT          (52 | SDMMC_CMD_R5)
// SDIO CMD53(R5): Extended IO read/write.
#define SDIO_CMD53_IO_R_BYTE_EXTENDED    (53 | SDMMC_CMD_R5 | SDMMC_CMD_SDIO_BYTE | SDMMC_CMD_READ)
#define SDIO_CMD53_IO_W_BYTE_EXTENDED    (53 | SDMMC_CMD_R5 | SDMMC_CMD_SDIO_BYTE | SDMMC_CMD_WRITE)
#define SDIO_CMD53_IO_R_BLOCK_EXTENDED   (53 | SDMMC_CMD_R5 | SDMMC_CMD_SDIO_BLOCK | SDMMC_CMD_READ)
#define SDIO_CMD53_IO_W_BLOCK_EXTENDED   (53 | SDMMC_CMD_R5 | SDMMC_CMD_SDIO_BLOCK | SDMMC_CMD_WRITE)

// SD CMD6 argument structure.

// CMD6 arg[ 3: 0] function group 1, access mode.
#define SD_CMD6_GRP1_HIGH_SPEED         (0x1 << 0)
#define SD_CMD6_GRP1_DEFAULT            (0x0 << 0)
// CMD6 arg[ 7: 4] function group 2, command system.
#define SD_CMD6_GRP2_NO_INFLUENCE       (0xF << 4)
#define SD_CMD6_GRP2_DEFAULT            (0x0 << 4)
// CMD6 arg[11: 8] function group 3, 0xF or 0x0.
#define SD_CMD6_GRP3_NO_INFLUENCE       (0xF << 8)
#define SD_CMD6_GRP3_DEFAULT            (0x0 << 8)
// CMD6 arg[15:12] function group 4, 0xF or 0x0.
#define SD_CMD6_GRP4_NO_INFLUENCE       (0xF << 12)
#define SD_CMD6_GRP4_DEFAULT            (0x0 << 12)
// CMD6 arg[19:16] function group 5, 0xF or 0x0.
#define SD_CMD6_GRP5_NO_INFLUENCE       (0xF << 16)
#define SD_CMD6_GRP5_DEFAULT            (0x0 << 16)
// CMD6 arg[23:20] function group 6, 0xF or 0x0.
#define SD_CMD6_GRP6_NO_INFLUENCE       (0xF << 20)
#define SD_CMD6_GRP6_DEFAULT            (0x0 << 20)
// CMD6 arg[31   ] Mode, 0: Check, 1: Switch.
#define SD_CMD6_MODE_CHECK              (0lu << 31)
#define SD_CMD6_MODE_SWITCH             (1lu << 31)

// SD CMD8 argument structure.
#define SD_CMD8_PATTERN                 0xAA
#define SD_CMD8_MASK_PATTERN            0xFF
#define SD_CMD8_HIGH_VOLTAGE            0x100
#define SD_CMD8_MASK_VOLTAGE            0xF00

// SD ACMD41 arguments.
#define SD_ACMD41_HCS                   (1lu << 30) /* (SD) Host Capacity Support. */

// Card Status Fields
#define CARD_STATUS_APP_CMD             (1 << 5)
#define CARD_STATUS_SWITCH_ERROR        (1 << 7)
#define CARD_STATUS_READY_FOR_DATA      (1 << 8)
#define CARD_STATUS_STATE_IDLE          (0 << 9)
#define CARD_STATUS_STATE_READY         (1 << 9)
#define CARD_STATUS_STATE_IDENT         (2 << 9)
#define CARD_STATUS_STATE_STBY          (3 << 9)
#define CARD_STATUS_STATE_TRAN          (4 << 9)
#define CARD_STATUS_STATE_DATA          (5 << 9)
#define CARD_STATUS_STATE_RCV           (6 << 9)
#define CARD_STATUS_STATE_PRG           (7 << 9)
#define CARD_STATUS_STATE_DIS           (8 << 9)
#define CARD_STATUS_STATE               (0xF << 9)
#define CARD_STATUS_ERASE_RESET         (1 << 13)
#define CARD_STATUS_WP_ERASE_SKIP       (1 << 15)
#define CARD_STATUS_CIDCSD_OVERWRITE    (1 << 16)
#define CARD_STATUS_OVERRUN             (1 << 17)
#define CARD_STATUS_UNERRUN             (1 << 18)
#define CARD_STATUS_ERROR               (1 << 19)
#define CARD_STATUS_CC_ERROR            (1 << 20)
#define CARD_STATUS_CARD_ECC_FAILED     (1 << 21)
#define CARD_STATUS_ILLEGAL_COMMAND     (1 << 22)
#define CARD_STATUS_COM_CRC_ERROR       (1 << 23)
#define CARD_STATUS_UNLOCK_FAILED       (1 << 24)
#define CARD_STATUS_CARD_IS_LOCKED      (1 << 25)
#define CARD_STATUS_WP_VIOLATION        (1 << 26)
#define CARD_STATUS_ERASE_PARAM         (1 << 27)
#define CARD_STATUS_ERASE_SEQ_ERROR     (1 << 28)
#define CARD_STATUS_BLOCK_LEN_ERROR     (1 << 29)
#define CARD_STATUS_ADDRESS_MISALIGN    (1 << 30)
#define CARD_STATUS_ADDR_OUT_OF_RANGE   (1 << 31)

#define CARD_STATUS_ERR_RD_WR           (CARD_STATUS_ADDR_OUT_OF_RANGE \
                                       | CARD_STATUS_ADDRESS_MISALIGN \
                                       | CARD_STATUS_BLOCK_LEN_ERROR \
                                       | CARD_STATUS_WP_VIOLATION \
                                       | CARD_STATUS_ILLEGAL_COMMAND \
                                       | CARD_STATUS_CC_ERROR \
                                       | CARD_STATUS_ERROR)

// CSD Fields.
#define CSD_REG_BIT_SIZE                (128)                       /* 128 bits. */
#define CSD_REG_BSIZE                   (CSD_REG_BIT_SIZE / 8)      /* 16 bytes. */
#define SD_CSD_VER_1_0                  0
#define SD_CSD_VER_2_0                  1
#define MMC_CSD_VER_1_0                 0
#define MMC_CSD_VER_1_1                 1
#define MMC_CSD_VER_1_2                 2

#define SD_SCR_REG_BIT_SIZE             (64)                        /* 64 bits. */
#define SD_SCR_REG_BSIZE                (SD_SCR_REG_BIT_SIZE / 8)   /* 8 bytes. */

#define SD_SW_STATUS_BIT_SIZE           (512)                       /* 512 bits. */
#define SD_SW_STATUS_BSIZE              (SD_SW_STATUS_BIT_SIZE / 8) /* 64 bytes. */

// OCR Register Fields.
#define OCR_REG_BSIZE                   (32 / 8)    /* 32 bits, 4 bytes. */
#define OCR_VDD_170_195                 (1 << 7)
#define OCR_VDD_20_21                   (1 << 8)
#define OCR_VDD_21_22                   (1 << 9)
#define OCR_VDD_22_23                   (1 << 10)
#define OCR_VDD_23_24                   (1 << 11)
#define OCR_VDD_24_25                   (1 << 12)
#define OCR_VDD_25_26                   (1 << 13)
#define OCR_VDD_26_27                   (1 << 14)
#define OCR_VDD_27_28                   (1 << 15)
#define OCR_VDD_28_29                   (1 << 16)
#define OCR_VDD_29_30                   (1 << 17)
#define OCR_VDD_30_31                   (1 << 18)
#define OCR_VDD_31_32                   (1 << 19)
#define OCR_VDD_32_33                   (1 << 20)
#define OCR_VDD_33_34                   (1 << 21)
#define OCR_VDD_34_35                   (1 << 22)
#define OCR_VDD_35_36                   (1 << 23)
#define OCR_SDIO_S18R                   (1 << 24) /* Switching to 1.8V Accepted */
#define OCR_SDIO_MP                     (1 << 27) /* Memory Present */
#define OCR_SDIO_NF                     (7 << 28) /* Number of I/O Functions */
#define OCR_ACCESS_MODE_MASK            (3 << 29) /* (MMC) Access mode mask */
#define OCR_ACCESS_MODE_BYTE            (0 << 29) /* (MMC) Byte access mode */
#define OCR_ACCESS_MODE_SECTOR          (2 << 29) /* (MMC) Sector access mode */
#define OCR_CCS                         (1 << 30) /* (SD) Card Capacity Status */
#define OCR_POWER_UP_BUSY               (1 << 31) /* Card power up status bit */

//-----------------------------------------------------------------------------

// Card Specific Data.
struct _CSD {
  union {
    uint8_t   b[CSD_REG_BSIZE];
    uint32_t  l[CSD_REG_BSIZE / 4];
  };
} CSD;

struct _SDCARDINFO {
  uint8_t     type;
  uint8_t     csdver;
  uint8_t     cardver;
  uint8_t     v2;
  uint8_t     scr[SD_SCR_REG_BSIZE];
  uint32_t    capacity;
  uint32_t    max_clk_speed;
  uint32_t    relative_addr;
  struct _CSD cid;
  struct _CSD csd;
  uint8_t     switch_status[SD_SW_STATUS_BSIZE];
  DSTATUS     stat;
};

extern void hsmci_init(void);
extern void hsmci_send_clock(void);
extern uint32_t hsmci_get_response(void);
extern uint32_t hsmci_get_status(void);
extern void hsmci_set_mode(uint32_t);
extern uint32_t  hsmci_get_mode(void);
extern int hsmci_send_command(uint32_t, uint32_t);
extern void hsmci_wait_busy(void);
extern void hsmci_set_4bitbus(void);
extern void hsmci_enable_rdwrproof(void);
extern void hsmci_disable_rdwrproof(void);
extern void hsmci_enable_forcebyte(void);
extern void hsmci_disable_forcebyte(void);
extern void hsmci_set_block(uint32_t);
extern uint32_t hsmci_get_block(void);
extern void hsmci_enable_dma(void);
extern void hsmci_disable_dma(void);
extern uint32_t hsmci_get_fifo(void);
extern void hsmci_set_data_timeout(uint32_t);
extern void hsmci_set_completion_timeout(uint32_t);

//-----------------------------------------------------------------------------
//end: sdmci.h
