##############################################################################
##
## file:makefile
##
## Smegduino ATSAME70 XDMAC Direct Memory Access Controller test program libraries.
## rev 0.
## Copyright (C) 2020 Dysfunctional Farms A.K.A. www.smegware.com
##
######################################################################################
# GNU GCC ARM Embeded Toolchain base directories and binaries 
######################################################################################
GCC_BASE  = /usr/arm-none-eabi/
GCC_BIN   = /usr/bin/
GCC_LIB   = $(GCC_BASE)lib/
GCC_INC   = $(GCC_BASE)include/
AS        = $(GCC_BIN)arm-none-eabi-as
CC        = $(GCC_BIN)arm-none-eabi-gcc
CPP       = $(GCC_BIN)arm-none-eabi-g++
LD        = $(GCC_BIN)arm-none-eabi-gcc
LIBRARIAN = $(GCC_BIN)arm-none-eabi-ar
OBJCOPY   = $(GCC_BIN)arm-none-eabi-objcopy
OBJDUMP   = $(GCC_BIN)arm-none-eabi-objdump

######################################################################################
# Custom options for cortex-m and cortex-r processors 
######################################################################################
CORTEX_M0PLUS_CC_FLAGS  = -mthumb -mcpu=cortex-m0plus
CORTEX_M0PLUS_LIB_PATH  = $(GCC_LIB)armv6-m
CORTEX_M0_CC_FLAGS      = -mthumb -mcpu=cortex-m0
CORTEX_M0_LIB_PATH      = $(GCC_LIB)armv6-m
CORTEX_M1_CC_FLAGS      = -mthumb -mcpu=cortex-m1
CORTEX_M1_LIB_PATH      = $(GCC_LIB)armv6-m
CORTEX_M3_CC_FLAGS      = -mthumb -mcpu=cortex-m3
CORTEX_M3_LIB_PATH      = $(GCC_LIB)armv7-m
CORTEX_M4_NOFP_CC_FLAGS = -mthumb -mcpu=cortex-m4
CORTEX_M4_NOFP_LIB_PATH = $(GCC_LIB)armv7e-m
CORTEX_M4_SWFP_CC_FLAGS = -mthumb -mcpu=cortex-m4 -mfloat-abi=softfp -mfpu=fpv4-sp-d16
CORTEX_M4_SWFP_LIB_PATH = $(GCC_LIB)armv7e-m/softfp
CORTEX_M4_HWFP_CC_FLAGS = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16
CORTEX_M4_HWFP_LIB_PATH = $(GCC_LIB)armv7e-m/fpu
CORTEX_M7_HWFP_CC_FLAGS = -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16
CORTEX_M7_HWFP_LIB_PATH = $(GCC_LIB)armv7e-m/fpu
CORTEX_R4_NOFP_CC_FLAGS = -mthumb -march=armv7-r
CORTEX_R4_NOFP_LIB_PATH = $(GCC_LIB)armv7-r/thumb
CORTEX_R4_SWFP_CC_FLAGS = -mthumb -march=armv7-r -mfloat-abi=softfp -mfloat-abi=softfp -mfpu=vfpv3-d16
CORTEX_R4_SWFP_LIB_PATH = $(GCC_LIB)armv7-r/thumb/softfp
CORTEX_R4_HWFP_CC_FLAGS = -mthumb -march=armv7-r -mfloat-abi=softfp -mfloat-abi=hard -mfpu=vfpv3-d16
CORTEX_R4_HWFP_LIB_PATH = $(GCC_LIB)armv7-r/thumb/fpu
CORTEX_R5_NOFP_CC_FLAGS = -mthumb -march=armv7-r
CORTEX_R5_NOFP_LIB_PATH = $(GCC_LIB)armv7-r/thumb
CORTEX_R5_SWFP_CC_FLAGS = -mthumb -march=armv7-r -mfloat-abi=softfp -mfloat-abi=softfp -mfpu=vfpv3-d16
CORTEX_R5_SWFP_LIB_PATH = $(GCC_LIB)armv7-r/thumb/softfp
CORTEX_R5_HWFP_CC_FLAGS = -mthumb -march=armv7-r -mfloat-abi=softfp -mfloat-abi=hard -mfpu=vfpv3-d16
CORTEX_R5_HWFP_LIB_PATH = $(GCC_LIB)armv7-r/thumb/fpu

######################################################################################
# Main makefile project configuration
#    PROJECT      = <name of the target to be built>
#    MCU_CC_FLAGS = <one of the CC_FLAGS above>
#    MCU_LIB_PATH = <one of the LIB_PATH above>
#    OPTIMIZE_FOR = < SIZE or nothing >
#    DEBUG_LEVEL  = < -g compiler option or nothing >
#    OPTIM_LEVEL  = < -O compiler option or nothing >
######################################################################################
LIBRARY        = ../../libs/libxdmac.a
LIBFLAGS       = rcs
MASTERCLOCK    = 150000000
HEADER         = xdmac.h
OBJECTS        = xdmac.o dmac.o
SYMBOLS        = -DTOOLCHAIN_GCC_ARM -DNO_RELOC='0' -DSYSTEMCLK='$(MASTERCLOCK)'
INCLUDEDIR     = ../
MCU_CC_FLAGS   = $(CORTEX_M7_HWFP_CC_FLAGS)
MCU_LIB_PATH   = $(CORTEX_M7_HWFP_LIB_PATH)
OPTIMIZE_FOR   = 
DEBUG_LEVEL    = 
OPTIM_LEVEL    =
LIB_INCLUDES   = -I. -I$(INCLUDEDIR)
LIB_LIBRARIES  =

######################################################################################
# Main makefile system configuration
######################################################################################
SYS_OBJECTS    = 
SYS_INCLUDES   = -I$(GCC_INC)
SYS_LIBRARIES  = -L$(MCU_LIB_PATH)
ifeq (OPTIMIZE_FOR, SIZE)
SYS_LIBRARIES  = -lm -lnosys
SYS_LD_FLAGS   = --specs=nano.specs -u _printf_float -u _scanf_float
else
SYS_LIBRARIES  = -lm -lnosys -lc
SYS_LD_FLAGS   = 
endif

############################################################################### 
# Command line building
###############################################################################
ifdef DEBUG_LEVEL
CC_DEBUG_FLAGS = -g$(DEBUG_LEVEL)
CC_SYMBOLS     = -DDEBUG $(SYMBOLS)
else
CC_DEBUG_FLAGS =
CC_SYMBOLS     = -DNODEBUG $(SYMBOLS)
endif 
ifdef OPTIM_LEVEL
CC_OPTIM_FLAGS = -O$(OPTIM_LEVEL)
else 
CC_OPTIM_FLAGS = 
endif
AS_SYMBOLS     = -I../ --defsym SYSTEMCLK=$(MASTERCLOCK) --defsym CONSOLEBAUD=115200

INCLUDE_PATHS = $(LIB_INCLUDES) $(SYS_INCLUDES)
LIBRARY_PATHS = $(LIB_LIBRARIES) $(SYS_LIBRARIES)
CC_FLAGS      = $(MCU_CC_FLAGS) -c $(CC_OPTIM_FLAGS) $(CC_DEBUG_FLAGS) -fmessage-length=0 -Wall 
LD_FLAGS      = $(MCU_CC_FLAGS) -Wl,--gc-sections $(SYS_LD_FLAGS) -Wl,-Map=$(PROJECT).map
LD_SYS_LIBS   = $(SYS_LIBRARIES)

BUILD_TARGET  = $(LIBRARY)

############################################################################### 
# Makefile execution
###############################################################################

all: $(BUILD_TARGET)

$(LIBRARY): $(OBJECTS)
	$(LIBRARIAN) $(LIBFLAGS) $(LIBRARY) $(OBJECTS)
	cp $(HEADER) $(INCLUDEDIR)$(HEADER)

clean:
	rm -f $(LIBRARY) $(OBJECTS)

.s.o:
	$(AS) $(MCU_CC_FLAGS) $(AS_SYMBOLS) -o $@ $<
.c.o:
	$(CC)  $(CC_FLAGS) $(CC_SYMBOLS) -std=gnu99   $(INCLUDE_PATHS) -o $@ $<

.cpp.o:
	$(CPP) $(CC_FLAGS) $(CC_SYMBOLS) -std=gnu++98 $(INCLUDE_PATHS) -o $@ $<

############################################################################### 
# Dependencies
###############################################################################

xdmac.o: xdmac.s

dmac.o: dmac.c xdmac.h

##############################################################################
##
## end:makefile
##
