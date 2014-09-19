
ifeq ($(target),ppc)
  CC        = /root/Desktop/tuxbox-cvs/root/cdk/bin/powerpc-tuxbox-linux-gnu-gcc
  OUTPUT	= ppc
  CFLAGS	= -s -ggdb3 -O2
else
ifeq ($(target),mips)
  CC        = /opt/mipsel-unknown-linux-gnu/bin/mipsel-unknown-linux-gnu-gcc
  OUTPUT	= mips
  CFLAGS	= -ggdb3 -O2
else
ifeq ($(target),mips-uclibc)
  CC        = /opt/toolchains/uclibc-crosstools-1.0.0/bin/mipsel-linux-gcc
  OUTPUT	= mips-uclibc
  CFLAGS	= -ggdb3 -O2
else
ifeq ($(target),rpi)
  CC        = /opt/tools-master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc
  OUTPUT	= rpi
  CFLAGS	= -ggdb3 -O2
else
ifeq ($(target),arm)
  CC        = /opt/OpenWrt-SDK-ixp4xx-2.6-for-Linux-i686/staging_dir_armeb/bin/armeb-linux-uclibc-gcc
  OUTPUT	= arm
  CFLAGS	= -ggdb3 -O2
else
ifeq ($(target),sh4)
  CC        = /opt/STM/STLinux-2.4/devkit/sh4/bin/sh4-linux-gcc
  OUTPUT	= sh4
  CFLAGS	= -ggdb3 -O2 $(OPTS) -DST_7201  -DST_OSLINUX  -DARCHITECTURE_ST40
else
ifeq ($(target),x32)
  CC        = gcc
  OUTPUT	= x32
  CFLAGS	= -ggdb3 -m32 -O3
else
ifeq ($(target),x64)
  CC        = gcc
  OUTPUT	= x64
  CFLAGS	= -ggdb3 -m64 -O3
else
  CC        = gcc
  OUTPUT	= x
  CFLAGS	= -ggdb3 -O3
endif
endif
endif
endif
endif
endif
endif
endif


#OUTPUT	= x/
LFLAGS	= -lpthread
NAME	= twin2cs

OBJECTS = $(OUTPUT)/tools.o $(OUTPUT)/convert.o $(OUTPUT)/debug.o $(OUTPUT)/des.o $(OUTPUT)/md5.o $(OUTPUT)/sockets.o $(OUTPUT)/serial.o \
		$(OUTPUT)/newcamd.o $(OUTPUT)/config.o $(OUTPUT)/threads.o $(OUTPUT)/httpserver.o $(OUTPUT)/main.o

link: $(OBJECTS)
	$(CC) -o $(OUTPUT)/$(NAME) $(OBJECTS) $(CFLAGS) $(LFLAGS)
	cp $(OUTPUT)/$(NAME) twin2cs/$(NAME).$(OUTPUT)

all:
	$(MAKE) target=x64
	$(MAKE) target=x32
	$(MAKE) target=ppc
	$(MAKE) target=mips
	$(MAKE) target=sh4
	$(MAKE) target=arm
	$(MAKE) target=rpi


compile: $(OBJECTS)

%.o: ../%.c Makefile common.h config.h
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	-rm *~
	-rm $(OUTPUT)/*
