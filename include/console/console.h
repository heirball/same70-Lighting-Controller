//----------------------------------------------------------------------------
// file: console.h
//
// SmegARM UART serial interface driver example.
//
// Copyright (c) 2017 - Dysfunctional Farms A.K.A. www.smegware.com
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
//----------------------------------------------------------------------------
//
// History...
//
//   $Source$
//   $Author$
// $Revision$
//
// $Log$
//
//----------------------------------------------------------------------------

#include <stdint.h>
#include <stdarg.h>
#include <string.h>
#include <stdio.h>

#if defined __cplusplus
extern "C"
{
#endif

extern void console_init(uint32_t);
extern int32_t console_read(void);
extern int32_t console_write(uint8_t);
extern void console_get_line(char*, size_t);
extern void console_send(const char*);
extern void console_send_line(const char*);
extern void console_print(char*, const char*, ...);

#if defined __cplusplus
}
#endif

//----------------------------------------------------------------------------
// end: console.h
