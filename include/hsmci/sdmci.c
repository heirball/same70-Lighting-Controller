//-----------------------------------------------------------------------------
// file: sdmci.c
//
// SmegARM ATSAME70 HSMCI High-Speed Multimedia Card Interface example.
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

#include <stdio.h>
#include <time.h>

#include <console.h>
#include <fatfs/ff.h>
#include <fatfs/diskio.h>
#include <pause.h>
#include <xdmac.h>

#include "sdmci.h"

#define ACMD41FLAGS (OCR_VDD_27_28 | OCR_VDD_28_29 | OCR_VDD_29_30 | \
                     OCR_VDD_30_31 | OCR_VDD_31_32 | OCR_VDD_32_33)

//-----------------------------------------------------------------------------

// SD/MMC transfer rate unit codes (1/10000) list.
__attribute__ ((section (".text.smegconst")))
static const uint16_t trans_unit[7] = {
	10, 100, 1000, 10000, 0, 0, 0
};

// SD transfer multiplier factor codes (1/10) list.
__attribute__ ((section (".text.smegconst")))
static const uint8_t trans_multiplier[16] = {
	0, 10, 12, 13, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80
};

static struct _SDCARDINFO sd_card_info;

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static void hsmci_get_response_128(uint32_t *response)
{
  for (uint8_t i = 0; i < 4; i++)
  {
    // Reading response through reg[0] auto increments upon
    //  consecutive reads of register.
    // DO NOT DO THIS MANUALLY!
    *response++ = hsmci_get_response();
  }
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static int hsmci_send_app_command(uint32_t cmd, uint32_t arg)
{
  int rtn;

  if(!(rtn = hsmci_send_command(SDMMC_CMD55_APP_CMD, sd_card_info.relative_addr)))
  {
    rtn = hsmci_send_command(cmd, arg);
  }
  return rtn;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static int hsmci_get_operating_condition(void)
{
  int rtn;
  uint32_t response;
  uint32_t retry = 2100;

  while(1)
  {
    if(sd_card_info.v2)
    {
      rtn = hsmci_send_app_command(SD_MCI_ACMD41_SD_SEND_OP_COND, ACMD41FLAGS | SD_ACMD41_HCS);
    }
    else
    {
      rtn = hsmci_send_app_command(SD_MCI_ACMD41_SD_SEND_OP_COND, ACMD41FLAGS);
    }
    if(!rtn)
    {
      response = hsmci_get_response();
      if(response & OCR_POWER_UP_BUSY)
      {
        if(response & OCR_CCS)
        {
          sd_card_info.type |= CARD_TYPE_HC;
        }
        // Card is ready.
        break;
      }
      if(retry-- == 0)
      {
        rtn = -1;
        break;
      }
      pause();
    }
    else
    {
      break;
    }
  }
	return rtn;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static int hsmci_get_device_addr(void)
{
  int rtn;
  // Read CID.
  if(!(rtn = hsmci_send_command(SDMMC_CMD2_ALL_SEND_CID, 0)))
  {
    hsmci_get_response_128(sd_card_info.cid.l);
    // Ask the card to publish a relative addr.
    if(!(rtn = hsmci_send_command(SD_CMD3_SEND_RELATIVE_ADDR, 0)))
    {
      sd_card_info.relative_addr = hsmci_get_response() & 0XFFFF0000;
    }
  }
  return rtn;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static void sd_get_max_transfer_speed(void)
{
  uint32_t tran_speed;
  uint32_t unit;
  uint32_t multi;

  // TRAN_SPEED 8-bits CSD[103:96].
  tran_speed = sd_card_info.csd.l[0] & 0X000000FF;
  unit = tran_speed & 0X07;
  multi = (tran_speed >> 3) & 0x0F;
  sd_card_info.max_clk_speed = trans_unit[unit] * trans_multiplier[multi] * 1000;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static void sd_get_capacity(void)
{
  uint32_t csize;
  uint32_t blklen;
  uint32_t szmulti;

  if(sd_card_info.csdver >= SD_CSD_VER_2_0)
  {
    // C_SIZE 22-bits CSD[75:48].
    // Capacity = (C_SIZE + 1) * 512.
    csize = (sd_card_info.csd.l[2] >> 16) | ((sd_card_info.csd.l[1] & 0X7FF) << 16);
    sd_card_info.capacity = (csize + 1) * 512;
  }
	else
  {
    // C_SIZE 12-bits CSD[73:62].
    // READ_BL_LEN 4-bits CSD[83:80].
    // C_SIZE_MULT 3-bits CSD[49:47].
    // Capacity = (C_SIZE + 1) * (4 << C_SIZE_MULT) * (2 << READ_BL_LEN).
    csize = ((sd_card_info.csd.l[1] & 0X3FF) << 2) | (sd_card_info.csd.l[2] >> 30);
    blklen = (sd_card_info.csd.l[1] >> 16) & 0X0F;
    szmulti = (sd_card_info.csd.l[2] >> 15) & 0X07;
    sd_card_info.capacity = (csize + 1) * (4 << szmulti) * (2 << blklen);
  }
}

//-----------------------------------------------------------------------------
//start data transfer command

__attribute__ ((section (".text.smeglib")))
static int hsmci_adtc_start(uint32_t cmd, uint32_t arg, uint16_t blocksize, uint16_t num_blocks)
{
  // Force byte transfer if needed.
  if(blocksize & 0x3)
  {
    hsmci_enable_forcebyte();
  }
  else
  {
    hsmci_disable_forcebyte();
  }
  if((cmd & HSMCI_TRTYPEMSK) == HSMCI_TRTYPE_BYTE)
  {
    // Value 0 corresponds to a 512-byte transfer
    hsmci_set_block(HSMCI_BCNT(blocksize % 512));
  }
  else
  {
    hsmci_set_block(HSMCI_BLKLEN(blocksize) | HSMCI_BCNT(num_blocks));
  }
  // Disable DMA channel
  xdmac_disable_channel(1 << XDMAC_CHANNEL_HWID_HSMCI);
  xdmac_set_block_control(XDMAC_CHANNEL_HWID_HSMCI, XDMAC_CBC_BLEN(0));
  xdmac_set_data_stride_msp(XDMAC_CHANNEL_HWID_HSMCI, 0);
  xdmac_set_source_micro_stride(XDMAC_CHANNEL_HWID_HSMCI, 0);
  xdmac_set_dest_micro_stride(XDMAC_CHANNEL_HWID_HSMCI, 0);
  return hsmci_send_command(cmd, arg);
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static int hsmci_wait_end_block_transfer(void)
{
  int rtn = 0;
  uint32_t timeout = 0x100000;

  // Read interrupt reg to clear any flags prior to enabling channel.
  xdmac_get_interrupt_status(XDMAC_CHANNEL_HWID_HSMCI);
  xdmac_enable_channel(1 << XDMAC_CHANNEL_HWID_HSMCI);
  while(!((hsmci_get_status()) & HSMCI_XFRDONE))
  {
    // Hardware TimOut/Error check.
    if(hsmci_get_status() & (HSMCI_UNRE | HSMCI_OVRE | HSMCI_DTOE | HSMCI_DCRCE))
    {
      xdmac_disable_channel(1 << XDMAC_CHANNEL_HWID_HSMCI);
      rtn = -1;
      break;
    }
    if(--timeout == 0)
    {
      rtn = -1;
      break;
    }
    pause();
  }
  return rtn;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static void hsmci_read_block(void *dest, uint32_t datasize)
{
  if((uint32_t)dest & 3)
  {
    xdmac_set_microblock_control(XDMAC_CHANNEL_HWID_HSMCI, datasize);
    xdmac_set_configuration(XDMAC_CHANNEL_HWID_HSMCI,
                            XDMAC_CC_TYPE_PER_TRAN
                            | XDMAC_CC_MBSIZE_SINGLE
                            | XDMAC_CC_DSYNC_PER2MEM
                            | XDMAC_CC_CSIZE_CHK_1
                            | XDMAC_CC_DWIDTH_BYTE
                            | XDMAC_CC_SIF_AHB_IF1
                            | XDMAC_CC_DIF_AHB_IF0
                            | XDMAC_CC_SAM_FIXED_AM
                            | XDMAC_CC_DAM_INCR_AM
                            | XDMAC_CC_PERID(0));
  }
  else
  {
    xdmac_set_microblock_control(XDMAC_CHANNEL_HWID_HSMCI, datasize / 4);
    xdmac_set_configuration(XDMAC_CHANNEL_HWID_HSMCI,
                            XDMAC_CC_TYPE_PER_TRAN
                            | XDMAC_CC_MBSIZE_SINGLE
                            | XDMAC_CC_DSYNC_PER2MEM
                            | XDMAC_CC_CSIZE_CHK_1
                            | XDMAC_CC_DWIDTH_WORD	
                            | XDMAC_CC_SIF_AHB_IF1
                            | XDMAC_CC_DIF_AHB_IF0
                            | XDMAC_CC_SAM_FIXED_AM
                            | XDMAC_CC_DAM_INCR_AM
                            | XDMAC_CC_PERID(0));
  }	
  xdmac_set_source_address(XDMAC_CHANNEL_HWID_HSMCI, hsmci_get_fifo());
  xdmac_set_dest_address(XDMAC_CHANNEL_HWID_HSMCI, (uint32_t)dest);
}			

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static void hsmci_write_block(const void *src, uint32_t datasize)
{
  if((uint32_t)src & 3)
  {
    xdmac_set_microblock_control(XDMAC_CHANNEL_HWID_HSMCI, datasize);
    xdmac_set_configuration(XDMAC_CHANNEL_HWID_HSMCI,
                            XDMAC_CC_TYPE_PER_TRAN
                            | XDMAC_CC_MBSIZE_SINGLE
                            | XDMAC_CC_DSYNC_MEM2PER
                            | XDMAC_CC_CSIZE_CHK_1
                            | XDMAC_CC_DWIDTH_BYTE
                            | XDMAC_CC_SIF_AHB_IF0
                            | XDMAC_CC_DIF_AHB_IF1
                            | XDMAC_CC_SAM_INCR_AM
                            | XDMAC_CC_DAM_FIXED_AM
                            | XDMAC_CC_PERID(0));
    }
    else
    {
    xdmac_set_microblock_control(XDMAC_CHANNEL_HWID_HSMCI, datasize / 4);
    xdmac_set_configuration(XDMAC_CHANNEL_HWID_HSMCI,
                            XDMAC_CC_TYPE_PER_TRAN
                            | XDMAC_CC_MBSIZE_SINGLE
                            | XDMAC_CC_DSYNC_MEM2PER
                            | XDMAC_CC_CSIZE_CHK_1
                            | XDMAC_CC_DWIDTH_WORD
                            | XDMAC_CC_SIF_AHB_IF0
                            | XDMAC_CC_DIF_AHB_IF1
                            | XDMAC_CC_SAM_INCR_AM
                            | XDMAC_CC_DAM_FIXED_AM
                            | XDMAC_CC_PERID(0));
  }
  xdmac_set_source_address(XDMAC_CHANNEL_HWID_HSMCI, (uint32_t)src);
  xdmac_set_dest_address(XDMAC_CHANNEL_HWID_HSMCI, hsmci_get_fifo());
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static int sd_get_card_version(void)
{
  int rtn;
  uint32_t cardversion = 0;

  if(!(rtn = hsmci_send_command(SDMMC_CMD55_APP_CMD, sd_card_info.relative_addr)))
  {
    if(!(rtn = hsmci_adtc_start(SD_ACMD51_SEND_SCR, 0, SD_SCR_REG_BSIZE, 1)))
    {
      hsmci_read_block(sd_card_info.scr, SD_SCR_REG_BSIZE);
      if(!(rtn = hsmci_wait_end_block_transfer()))
      {
        // Extract card version from SCR.
        cardversion = (sd_card_info.scr[0] & 0X0F) << 6;
        cardversion |= (sd_card_info.scr[2] & 0X80) >> 2;
        cardversion |= (sd_card_info.scr[2] & 0X04) << 2;
        switch(cardversion)
        {
          case 0X40:
            sd_card_info.cardver = CARD_VER_SD_1_10;
            break;
        
          case 0X80:
            sd_card_info.cardver = CARD_VER_SD_2_0;
            break;
        
          case 0XA0:
            sd_card_info.cardver = CARD_VER_SD_3_0;
            break;
        
          case 0XB0:
            sd_card_info.cardver = CARD_VER_MMC_4;
            break;
        
          case 0X00:
          default:
            sd_card_info.cardver = CARD_VER_SD_1_0;
            break;
        }
      }
    }
  }
  return rtn;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static int hsmci_set_high_speed(void)
{
  int rtn;

  if(!(rtn = hsmci_adtc_start(SD_CMD6_SWITCH_FUNC,
                              SD_CMD6_MODE_SWITCH |
                              SD_CMD6_GRP6_NO_INFLUENCE |
                              SD_CMD6_GRP5_NO_INFLUENCE |
                              SD_CMD6_GRP4_NO_INFLUENCE |
                              SD_CMD6_GRP3_NO_INFLUENCE |
                              SD_CMD6_GRP2_DEFAULT |
                              SD_CMD6_GRP1_HIGH_SPEED,
                              SD_SW_STATUS_BSIZE, 1)))
  {
    hsmci_read_block(sd_card_info.switch_status, SD_SW_STATUS_BSIZE);
    if(!(rtn = hsmci_wait_end_block_transfer()))
    {
      // Clock is Double the max data speed.
      sd_card_info.max_clk_speed *= 2;
      // Configure HSMCI CLK.
      hsmci_set_mode(HSMCI_CLKDIV((SYSTEMCLK / 2) / sd_card_info.max_clk_speed) |
                     HSMCI_CLKODD |
                     HSMCI_PWSDIVMSK);
    }
  }
  return rtn;
}

//-----------------------------------------------------------------------------

#define ascii(c)  (((c >= ' ') && (c <= '~')) ? (c) : '.') 

__attribute__ ((section (".text.smeglib")))
void sd_print_info(void)
{
  int i;
  char console[80];

  console_send("Card Info:\n");
  console_print(console, "      V2 : %i\n", sd_card_info.v2);
  if(sd_card_info.type & CARD_TYPE_HC)
  {
    console_send("    Type : SDHC\n");
  }
  else
  {
    console_send("    Type : SD\n");
  }
  switch(sd_card_info.cardver)
  {
    case CARD_VER_SD_1_0:
      console_send(" Version : 1.0 / 1.01\n");
      break;

    case CARD_VER_SD_1_10:
      console_send(" Version : 1.1\n");
      break;

    case CARD_VER_SD_2_0:
      console_send(" Version : 2.0\n");
      break;

    case CARD_VER_SD_3_0:
      console_send(" Version : 3.0\n");
      break;

    default:
      console_send(" Version : Unknown\n");
      break;
  }
  console_print(console, " CSD Ver : %i\n", sd_card_info.csdver);
  console_print(console, "     CSD : %02X%02X%02X%02X",
                sd_card_info.csd.b[3],sd_card_info.csd.b[2],
                sd_card_info.csd.b[1],sd_card_info.csd.b[0]);
  console_print(console, "%02X%02X%02X%02X",
                sd_card_info.csd.b[7],sd_card_info.csd.b[6],
                sd_card_info.csd.b[5],sd_card_info.csd.b[4]);
  console_print(console, "%02X%02X%02X%02X",
                sd_card_info.csd.b[11],sd_card_info.csd.b[10],
                sd_card_info.csd.b[9],sd_card_info.csd.b[8]);
  console_print(console, "%02X%02X%02X%02X\n",
                sd_card_info.csd.b[15],sd_card_info.csd.b[14],
                sd_card_info.csd.b[13],sd_card_info.csd.b[12]);
  console_print(console, "     CID : %02X%02X%02X%02X",
                sd_card_info.cid.b[3],sd_card_info.cid.b[2],
                sd_card_info.cid.b[1],sd_card_info.cid.b[0]);
  console_print(console, "%02X%02X%02X%02X",
                sd_card_info.cid.b[7],sd_card_info.cid.b[6],
                sd_card_info.cid.b[5],sd_card_info.cid.b[4]);
  console_print(console, "%02X%02X%02X%02X",
                sd_card_info.cid.b[11],sd_card_info.cid.b[10],
                sd_card_info.cid.b[9],sd_card_info.cid.b[8]);
  console_print(console, "%02X%02X%02X%02X | ",
                sd_card_info.cid.b[15],sd_card_info.cid.b[14],
                sd_card_info.cid.b[13],sd_card_info.cid.b[12]);
  console[0]  = ascii(sd_card_info.cid.b[3]);
  console[1]  = ascii(sd_card_info.cid.b[2]);
  console[2]  = ascii(sd_card_info.cid.b[1]);
  console[3]  = ascii(sd_card_info.cid.b[0]);
  console[4]  = ascii(sd_card_info.cid.b[7]);
  console[5]  = ascii(sd_card_info.cid.b[6]);
  console[6]  = ascii(sd_card_info.cid.b[5]);
  console[7]  = ascii(sd_card_info.cid.b[4]);
  console[8]  = ascii(sd_card_info.cid.b[11]);
  console[9]  = ascii(sd_card_info.cid.b[10]);
  console[10] = ascii(sd_card_info.cid.b[9]);
  console[11] = ascii(sd_card_info.cid.b[8]);
  console[12] = ascii(sd_card_info.cid.b[15]);
  console[13] = ascii(sd_card_info.cid.b[14]);
  console[14] = ascii(sd_card_info.cid.b[13]);
  console[15] = ascii(sd_card_info.cid.b[12]);
  console[16] = '\n';
  console[17] = '\0';
  console_send(console);
  console_print(console, "     RCA : %08X\n",sd_card_info.relative_addr);
  console_print(console, "    Size : %lu MB\n", (sd_card_info.capacity / 1024));
  console_print(console, "     CLK : %lu Hz\n", (sd_card_info.max_clk_speed));
  console_print(console, "     SCR : %02X%02X%02X%02X",
                sd_card_info.scr[0], sd_card_info.scr[1],
                sd_card_info.scr[2], sd_card_info.scr[3]);
  console_print(console, "%02X%02X%02X%02X\n",
                sd_card_info.scr[4], sd_card_info.scr[5],
                sd_card_info.scr[6], sd_card_info.scr[7]);
  console_send("Switch Status:\n");
 	for(i = 0; i < SD_SW_STATUS_BSIZE; i += 8)
  {
    console_print(console, "%04X  %02X %02X %02X %02X", i,
                  sd_card_info.switch_status[i], sd_card_info.switch_status[i + 1],
                  sd_card_info.switch_status[i + 2], sd_card_info.switch_status[i + 3]);
    console_print(console, " %02X %02X %02X %02X\n",
                  sd_card_info.switch_status[i + 4], sd_card_info.switch_status[i + 5],
                  sd_card_info.switch_status[i + 6], sd_card_info.switch_status[i + 7]);
  }
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DSTATUS sd_initialize(void)
{
  uint32_t response;

  memset(&sd_card_info, 0, sizeof(struct _SDCARDINFO));
  sd_card_info.type    = CARD_TYPE_SD;
  sd_card_info.csdver  = SD_CSD_VER_UNKNOWN;
  sd_card_info.cardver = CARD_VER_UNKNOWN;
  sd_card_info.stat = STA_NOINIT;
  // Initialize HSMCI module hardware.
  hsmci_init();
  // Enable XDMAC module clock.
  xdmac_enable_pmc();
  // Send 74 clock cycles to start card.
  hsmci_send_clock();
  // All data transfers use DMA.
  hsmci_enable_dma();
  // Enabling Read/Write Proof allows to stop the HSMCI Clock during
  // read/write access if the internal FIFO is full.
  // This will guarantee data integrity, not bandwidth.
  hsmci_enable_rdwrproof();
  // Reset cards to idle state.
  if(!hsmci_send_command(SDMMC_MCI_CMD0_GO_IDLE_STATE, 0))
  {
    // test for SD v2	
    if(!hsmci_send_command(SD_CMD8_SEND_IF_COND,
                           SD_CMD8_PATTERN | SD_CMD8_HIGH_VOLTAGE))
    {
      response = hsmci_get_response();
      if(response == 0xFFFFFFFF ||
        ((response & (SD_CMD8_MASK_PATTERN | SD_CMD8_MASK_VOLTAGE)) !=
         (SD_CMD8_PATTERN | SD_CMD8_HIGH_VOLTAGE)))
      {
        sd_card_info.v2 = 0;
      }
      else
      {
        sd_card_info.v2 = 1;
      }
      // Get operating conditions, check if card is high capacity.
      if(!hsmci_get_operating_condition())
      {
        // Ask card for CID number and relative card address.
        hsmci_get_device_addr();
	      if(sd_card_info.relative_addr == 0)
        {
          // Card not responding or none found; No need to continue.
          sd_card_info.stat |= STA_NODISK;
        }
        else
        {
          //*********************************************************************
          // Initialization mode of card is over here, card now in standby state.
          //*********************************************************************
          // Read card specific data.
          if(!hsmci_send_command(SDMMC_MCI_CMD9_SEND_CSD, sd_card_info.relative_addr))
          {
            hsmci_get_response_128(sd_card_info.csd.l);
            sd_card_info.csdver = (sd_card_info.csd.l[0] >> 30) + 1;
            sd_get_max_transfer_speed();
            sd_get_capacity();
            //select the card to put it in data transfer mode.
            if(!hsmci_send_command(SDMMC_CMD7_SELECT_CARD_CMD, sd_card_info.relative_addr))
            {
              // Get SD version by reading config reg.
              sd_get_card_version();
              // Enable high speed mode if possible.
              if((sd_card_info.cardver > CARD_VER_SD_1_0) && (sd_card_info.type & CARD_TYPE_SD))
              {
                hsmci_set_high_speed();
                // Set Data/Completion timeouts.
                hsmci_set_data_timeout(HSMCI_TOMUL4096 | HSMCI_TOCYC(5));
                hsmci_set_completion_timeout(HSMCI_TOMUL1024 | HSMCI_TOCYC(3));
              }
	            // Enable bus width of 4bits.
	            if(!hsmci_send_app_command(SD_ACMD6_SET_BUS_WIDTH, 0x02))
              {
                // Switch HSMCI to 4 bit wide bus.
                hsmci_set_4bitbus();
              }
              // Set default blocksize.
              hsmci_send_command(SDMMC_CMD16_SET_BLOCKLEN, HSMCI_DMA_BLOCKSZ);
              //************************************************************
              // Card is initialized and should be ready for data transfers.
              //*************************************************************
	            sd_card_info.stat &= ~STA_NOINIT;
            }
          }
        }
      }
    }
  }
	return sd_card_info.stat;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
static int hsmci_sd_wait_ready(void)
{
  int rtn;
  uint32_t retry = 2000;

  // Wait for data ready status.
  while(1)
  {
    rtn = hsmci_send_command(SDMMC_MCI_CMD13_SEND_STATUS, sd_card_info.relative_addr);
    if(rtn == -1)
    {
      break;
    }
    if(hsmci_get_response() & CARD_STATUS_READY_FOR_DATA)
    {
      break;
    }
    if(retry-- == 0)
    {
      rtn = -1;
      break;
    }
    pause();
  }
  return rtn;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DRESULT sd_read_blocks(void *dst, uint16_t num_blocks, uint32_t startaddr)
{
  int rtn = RES_ERROR;
  uint32_t cmd, arg;

  if(!hsmci_sd_wait_ready())
  {
    if(num_blocks > 1)
    {
      cmd = SDMMC_CMD18_READ_MULTIPLE_BLOCK;
    }
    else
    {
      cmd = SDMMC_CMD17_READ_SINGLE_BLOCK;
    }
    if(sd_card_info.type & CARD_TYPE_HC)
    {
      arg = startaddr;
    }
    else
    {
      arg = (startaddr * HSMCI_DMA_BLOCKSZ);
    }
    if(!(rtn = hsmci_adtc_start(cmd, arg, HSMCI_DMA_BLOCKSZ, num_blocks)))
    {
      // Check for error code?
      hsmci_read_block(dst, HSMCI_DMA_BLOCKSZ * num_blocks);
      rtn = hsmci_wait_end_block_transfer();
      hsmci_send_command(SDMMC_CMD12_STOP_TRANSMISSION, 0);
    }
    if(rtn)
    {
      rtn = RES_PARERR;
    }
  }
  return rtn;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DRESULT sd_write_blocks(const void *src, uint16_t num_blocks, uint32_t startaddr)
{
  int rtn = RES_ERROR;
  uint32_t cmd, arg;

  if(!hsmci_sd_wait_ready())
  {
    if(num_blocks > 1)
    {
      cmd = SDMMC_CMD25_WRITE_MULTIPLE_BLOCK;
    }
    else
    {
      cmd = SDMMC_CMD24_WRITE_BLOCK;
    }
    if(sd_card_info.type & CARD_TYPE_HC)
    {
      arg = startaddr;
    }
    else
    {
      arg = (startaddr * HSMCI_DMA_BLOCKSZ);
    }
    // Address counter is reset here.
    if(!(rtn = hsmci_adtc_start(cmd, arg, HSMCI_DMA_BLOCKSZ, num_blocks)))
    {
      // Check for error code?
      hsmci_write_block(src, HSMCI_DMA_BLOCKSZ * num_blocks);
      rtn = hsmci_wait_end_block_transfer();
      hsmci_send_command(SDMMC_CMD12_STOP_TRANSMISSION, 0);
    }
    if(rtn)
    {
      rtn = RES_PARERR;
    }
  }
  return rtn;	
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DRESULT sd_get_status(void)
{
  return sd_card_info.stat;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DWORD get_fattime (void)
{
  time_t t;
  struct tm *tm;

  t = time(NULL);
  tm = localtime(&t);
  uint32_t timestamp = (((tm->tm_year + 1900) - 1980) << 25)  // Year.
                       | ((tm->tm_mon + 1) << 21)             // Month.
                       | (tm->tm_mday << 16)                  // Day.
                       | (tm->tm_hour << 11)                  // Hour.
                       | (tm->tm_min << 5)                    // Minute.
                       | (tm->tm_sec / 2);                    // Second.
  return timestamp;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DRESULT sd_get_cid(uint8_t *cid)
{
  memcpy(cid, (uint8_t*)sd_card_info.cid.b, 16);
  return sd_card_info.stat;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DRESULT sd_get_csd(uint8_t *csd)
{
  memcpy(csd, (uint8_t*)sd_card_info.csd.b, 16);
  return sd_card_info.stat;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
uint32_t sd_get_device_addr(void)
{
  return sd_card_info.relative_addr;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
uint32_t sd_get_size(void)
{
  return sd_card_info.capacity;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
uint32_t sd_get_speed(void)
{
  return sd_card_info.max_clk_speed;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
uint32_t sd_get_type(void)
{
  return sd_card_info.type;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
uint32_t sd_get_version(void)
{
  return sd_card_info.cardver;
}

//-----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
DRESULT sd_ioctl(uint8_t cmd, void *buff)
{
  DRESULT res;

  if(sd_card_info.stat & STA_NOINIT)
  {
    res = RES_NOTRDY;	// No point if card isn't ready.
  }
  else
  {
    res = RES_ERROR;
    switch(cmd)
    {
      case CTRL_SYNC:		// Make sure all data has been written on the media.
        if(hsmci_sd_wait_ready())
        {
          res = RES_OK;
        }
        break;
    }
  }
  return res;
}

//-----------------------------------------------------------------------------
//end: sdmci.c
