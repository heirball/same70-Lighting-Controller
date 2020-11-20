//----------------------------------------------------------------------------
// file: led.h
//
// SmegARM GPIO 7-Segment LED Display driver example.
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

#if defined __cplusplus
extern "C"
{
#endif

extern void led_init(void);
extern int32_t led_set_digit(uint32_t, uint32_t);
extern int32_t led_clr_digit(uint32_t);

#if defined __cplusplus
}
#endif

//----------------------------------------------------------------------------
// end: led.h
