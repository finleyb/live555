##### Change the following for your environment:

NDK	?= $(HOME)/Android/Sdk/ndk/22.1.7171670
TOOLCHAIN = $(NDK)/toolchains/llvm/prebuilt/linux-x86_64

# Only choose one of these, depending on your device...
# TARGET=aarch64-linux-android
# TARGET=armv7a-linux-androideabi
# TARGET=i686-linux-android
TARGET=x86_64-linux-android

# Set this to your minSdkVersion.
API=24
# Configure and build.
AR=$(TOOLCHAIN)/bin/llvm-ar
CC=$(TOOLCHAIN)/bin/$(TARGET)$(API)-clang
AS=$(CC)
CXX=$(TOOLCHAIN)/bin/$(TARGET)$(API)-clang++
LD=$(TOOLCHAIN)/bin/ld
RANLIB=$(TOOLCHAIN)/bin/llvm-ranlib
STRIP=$(TOOLCHAIN)/bin/llvm-strip

COMPILE_OPTS = $(INCLUDES) -I. -O2 -DSOCKLEN_T=socklen_t -DNO_SSTREAM=1 -D_LARGEFILE_SOURCE=1 -DLOCALE_NOT_USED -DXLOCALE_NOT_USED -DNO_OPENSSL #$(ANDROID_CFLAGS)

C =			c
CPP =			cpp
C_COMPILER =		$(CC)
C_FLAGS = $(COMPILE_OPTS)
CPLUSPLUS_COMPILER =	$(CXX)
CPLUSPLUS_FLAGS = $(COMPILE_OPTS) -Wall -DBSD=1 -fPIC #$(ANDROID_CFLAGS)
OBJ =			o

LINK = $(CXX) -o
LINK_OPTS =
CONSOLE_LINK_OPTS =	$(LINK_OPTS) $(ANDROID_LDFLAGS)
LIBRARY_LINK =		$(TOOLCHAIN)/bin/$(TARGET)-ar cr 
LIBRARY_LINK_OPTS = $(LINK_OPTS)

LIB_SUFFIX =			a
LIBS_FOR_CONSOLE_APPLICATION = #-lssl -lcrypto
LIBS_FOR_GUI_APPLICATION =
EXE =

# $(info CPP:)
# $(info $(CPP))
# $(info **********************)##### End of variables to change

LIVEMEDIA_DIR = liveMedia
GROUPSOCK_DIR = groupsock
USAGE_ENVIRONMENT_DIR = UsageEnvironment
BASIC_USAGE_ENVIRONMENT_DIR = BasicUsageEnvironment

TESTPROGS_DIR = testProgs

MEDIA_SERVER_DIR = mediaServer

PROXY_SERVER_DIR = proxyServer

HLS_PROXY_DIR = hlsProxy

GADEPS = ./gadeps
LIVE555DIR = .

all:
	cd $(LIVEMEDIA_DIR) ; $(MAKE)
	cd $(GROUPSOCK_DIR) ; $(MAKE)
	cd $(USAGE_ENVIRONMENT_DIR) ; $(MAKE)
	cd $(BASIC_USAGE_ENVIRONMENT_DIR) ; $(MAKE)
	cd $(TESTPROGS_DIR) ; $(MAKE)
	cd $(MEDIA_SERVER_DIR) ; $(MAKE)
	cd $(PROXY_SERVER_DIR) ; $(MAKE)
	cd $(HLS_PROXY_DIR) ; $(MAKE)
	@echo
	@echo "For more information about this source code (including your obligations under the LGPL), please see our FAQ at http://live555.com/liveMedia/faq.html"
	-mkdir -p $(GADEPS)/$(TARGET)/lib
	find $(LIVE555DIR) -name '*.a' -exec cp -f {} $(GADEPS)/$(TARGET)/lib \;
	-mkdir -p $(GADEPS)/$(TARGET)/include/live555
	find $(LIVE555DIR) -name '*.hh' -exec cp -f {} $(GADEPS)/$(TARGET)/include/live555 \;
	cp -f $(LIVE555DIR)/groupsock/include/NetCommon.h $(GADEPS)/$(TARGET)/include/live555

install:
	cd $(LIVEMEDIA_DIR) ; $(MAKE) install
	cd $(GROUPSOCK_DIR) ; $(MAKE) install
	cd $(USAGE_ENVIRONMENT_DIR) ; $(MAKE) install
	cd $(BASIC_USAGE_ENVIRONMENT_DIR) ; $(MAKE) install
	cd $(TESTPROGS_DIR) ; $(MAKE) install
	cd $(MEDIA_SERVER_DIR) ; $(MAKE) install
	cd $(PROXY_SERVER_DIR) ; $(MAKE) install
	cd $(HLS_PROXY_DIR) ; $(MAKE) install

clean:
	cd $(LIVEMEDIA_DIR) ; $(MAKE) clean
	cd $(GROUPSOCK_DIR) ; $(MAKE) clean
	cd $(USAGE_ENVIRONMENT_DIR) ; $(MAKE) clean
	cd $(BASIC_USAGE_ENVIRONMENT_DIR) ; $(MAKE) clean
	cd $(TESTPROGS_DIR) ; $(MAKE) clean
	cd $(MEDIA_SERVER_DIR) ; $(MAKE) clean
	cd $(PROXY_SERVER_DIR) ; $(MAKE) clean
	cd $(HLS_PROXY_DIR) ; $(MAKE) clean

distclean: clean
	-rm -f $(LIVEMEDIA_DIR)/Makefile $(GROUPSOCK_DIR)/Makefile \
	  $(USAGE_ENVIRONMENT_DIR)/Makefile $(BASIC_USAGE_ENVIRONMENT_DIR)/Makefile \
	  $(TESTPROGS_DIR)/Makefile $(MEDIA_SERVER_DIR)/Makefile \
	  $(PROXY_SERVER_DIR)/Makefile \
	  $(HLS_PROXY_DIR)/Makefile \
	  Makefile