//-----------------------------------------------------------------------------
// file: hsmci.h
//
// SmegARM ATSAME70 HSMCI interface driver example.
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
#include <fatfs/ff.h>
#include <fatfs/diskio.h>

extern DSTATUS sd_initialize(void);
extern uint32_t sd_get_device_addr(void);
//extern uint8_t sd_get_operating_condition(uint8_t v2);
extern DRESULT sd_get_status(void);
extern DRESULT sd_read_blocks(void *dst, uint16_t num_blocks, uint32_t startaddr);
extern DRESULT sd_write_blocks(const void *src, uint16_t num_blocks, uint32_t startaddr);
extern DRESULT sd_ioctl(uint8_t cmd, void *buff);
extern DRESULT sd_get_cid(uint8_t*);
extern DRESULT sd_get_csd(uint8_t*);
extern void sd_print_info(void);
extern uint32_t sd_get_size(void);
extern uint32_t sd_get_speed(void);
extern uint32_t sd_get_type(void);
extern uint32_t sd_get_version(void);

//------------------------------------------------------------------------------
// end: hsmci.h
