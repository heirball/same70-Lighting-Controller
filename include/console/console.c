//----------------------------------------------------------------------------
// file:console.c
//
// SmegARM UART serial interface driver example.
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

/*#include <chip.h>*/
#include "console.h"

//----------------------------------------------------------------------------

#if defined __cplusplus
extern "C"
{
#endif

//----------------------------------------------------------------------------

extern void _console_init(uint32_t);

//----------------------------------------------------------------------------
// Because it's defined in another library.

void consolepause(void)
{
}
void pause(void) __attribute__ ((weak, alias("consolepause")));

//----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
void console_init(uint32_t baud)
{
  _console_init((((((uint64_t)SYSTEMCLK * 10) / baud) / 16) + 5) / 10);
}

//----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
void console_get_line(char *buffer, size_t size)
{
  int32_t c;
  uint16_t i;
    
  for(i = 0; i < size; i++)
  {
    while((c = console_read()) == -1)
    {
      pause();
    }
    if(c == '\n')
    {
      buffer[i] = 0;
      break;
    }
    buffer[i] = c;
  }
  buffer[size - 1] = '\0';
}

//----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
void console_send(const char *data)
{
  uint16_t i;
  uint16_t len = strlen(data);

  pause();
  for(i = 0; i < len; i++)
  {
    while(console_write(data[i]) == -1)
    {
      pause();
    }
  }
}

//----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
void console_send_line(const char *data)
{
  console_send(data);
  while(console_write('\n') == -1)
  {
    pause();
  }
  pause();
}

//----------------------------------------------------------------------------

__attribute__ ((section (".text.smeglib")))
void console_print(char *buf, const char *format, ...)
{
  uint16_t i;
  uint16_t len;
  va_list args;
    
  pause();
  va_start(args, format);
  vsprintf(buf, format, args);
  va_end(args);
  len = strlen(buf);
  for(i = 0; i < len; i++)
  {
    while(console_write(buf[i]) == -1)
    {
      pause();
    }
  }
  pause();
}

//----------------------------------------------------------------------------

#if defined __cplusplus
}
#endif

//----------------------------------------------------------------------------
// end:console.c
