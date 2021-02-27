//----------------------------------------------------------------------------
// file: dmac.c
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

#include "xdmac.h"

//----------------------------------------------------------------------------
// bascicly the same as the prepare_dma_channel() in ASF.

__attribute__ ((section (".text.smeglib")))
void xdmac_prepare_channel(uint32_t channel)
{
  xdmac_enable_pmc();
  xdmac_get_global_status();
  xdmac_get_global_interrupt_status();
  xdmac_get_interrupt_status(channel);
  xdmac_disable_global_interrupt(1 << channel);
  xdmac_disable_channel_interrupt(channel, 0X7F);
  xdmac_disable_channel(1 << channel);
  xdmac_set_source_address(channel, 0);
  xdmac_set_dest_address(channel, 0);
  xdmac_set_block_control(channel, 0);
  xdmac_set_configuration(channel, 0);
  xdmac_set_next_address(channel, 0);
  xdmac_set_next_control(channel, 0);
}

//----------------------------------------------------------------------------
// end: dmac.c

