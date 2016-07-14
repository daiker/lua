# Makefile Version 2.1
#
# ============================================================================
# Copyright (c) Moonlight Daiker Inc 2014
#
# Use of this software is controlled by the terms and conditions found in the
# license agreement under which this software has been supplied or provided.
# ============================================================================

TARGET = bin/$(notdir $(CURDIR))
# Comment this out if you want to see full compiler and linker output.
VERBOSE = @

CROSS_COMPILE=
#CROSS_COMPILE=arm-none-linux-gnueabi-
#CROSS_COMPILE=arm_v5t_le-


CC=$(CROSS_COMPILE)gcc

#C_FLAGS += -Wall -g -O
C_FLAGS += -Wall -g
LD_FLAGS += -lpthread -lm -ldl
LUAC_FLAGS += -Wall -shared -fPIC 

INCLUDE_PATH := -I ./inc 

COMPILE.c = $(VERBOSE) $(CC) $(C_FLAGS) -c
LINK.c = $(VERBOSE) $(CC) $(LD_FLAGS)

SOURCES = $(wildcard *.c) $(wildcard src/*.c)
HEADERS = $(wildcard *.h) $(wildcard inc/*.h)

LUA_LIB = lib/liblua.a
LUA_CLIB = lib/power.so

OBJFILES = $(SOURCES:%.c=%.o)

.PHONY: clean install

all:	daiker

daiker:	daiker_al

daiker_al:	$(TARGET)

$(TARGET):	$(OBJFILES) $(LUA_LIB) $(LUA_CLIB) 
	@echo Linking $@ from $^..
	$(LINK.c) $(INCLUDE_PATH) -o $@ $^

$(OBJFILES):	%.o: %.c $(HEADERS) $(XDC_CFLAGS)
	@echo Compiling $@ from $<..
	$(COMPILE.c) $(INCLUDE_PATH) -o $@ $<

$(XDC_LFILE) $(XDC_CFLAGS):	$(XDC_CFGFILE)
	@echo
	@echo ======== Building $(TARGET) ========
	@echo Configuring application using $<
	@echo
	$(VERBOSE) XDCPATH="$(XDC_PATH)" $(CONFIGURO) -c $(MVTOOL_DIR) -o $(XDC_CFG) -t $(XDC_TARGET) -p $(XDC_PLATFORM) $(XDC_CFGFILE)

$(LUA_CLIB) : clib/power.c 
	$(CC) $(LUAC_FLAGS) $(INCLUDE_PATH) $^ -o $@ 
	
clean:
	$(VERBOSE) -$(RM) -rf  $(OBJFILES) $(TARGET) *~ *.d .dep
