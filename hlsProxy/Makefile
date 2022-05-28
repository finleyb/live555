PREFIX = /usr/local
INCLUDES = -I../UsageEnvironment/include -I../groupsock/include -I../liveMedia/include -I../BasicUsageEnvironment/include
# Default library filename suffixes for each library that we link with.  The "config.*" file might redefine these later.
libliveMedia_LIB_SUFFIX = $(LIB_SUFFIX)
libBasicUsageEnvironment_LIB_SUFFIX = $(LIB_SUFFIX)
libUsageEnvironment_LIB_SUFFIX = $(LIB_SUFFIX)
libgroupsock_LIB_SUFFIX = $(LIB_SUFFIX)
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

HLS_PROXY = live555HLSProxy$(EXE)

ALL = $(HLS_PROXY)
all: $(ALL)

.$(C).$(OBJ):
	$(C_COMPILER) -c $(C_FLAGS) $<
.$(CPP).$(OBJ):
	$(CPLUSPLUS_COMPILER) -c $(CPLUSPLUS_FLAGS) $<

HLS_PROXY_OBJS = live555HLSProxy.$(OBJ)

USAGE_ENVIRONMENT_DIR = ../UsageEnvironment
USAGE_ENVIRONMENT_LIB = $(USAGE_ENVIRONMENT_DIR)/libUsageEnvironment.$(libUsageEnvironment_LIB_SUFFIX)
BASIC_USAGE_ENVIRONMENT_DIR = ../BasicUsageEnvironment
BASIC_USAGE_ENVIRONMENT_LIB = $(BASIC_USAGE_ENVIRONMENT_DIR)/libBasicUsageEnvironment.$(libBasicUsageEnvironment_LIB_SUFFIX)
LIVEMEDIA_DIR = ../liveMedia
LIVEMEDIA_LIB = $(LIVEMEDIA_DIR)/libliveMedia.$(libliveMedia_LIB_SUFFIX)
GROUPSOCK_DIR = ../groupsock
GROUPSOCK_LIB = $(GROUPSOCK_DIR)/libgroupsock.$(libgroupsock_LIB_SUFFIX)
LOCAL_LIBS =	$(LIVEMEDIA_LIB) $(GROUPSOCK_LIB) \
		$(BASIC_USAGE_ENVIRONMENT_LIB) $(USAGE_ENVIRONMENT_LIB)
LIBS =			$(LOCAL_LIBS) $(LIBS_FOR_CONSOLE_APPLICATION)

live555HLSProxy$(EXE):	$(HLS_PROXY_OBJS) $(LOCAL_LIBS)
	$(LINK)$@ $(CONSOLE_LINK_OPTS) $(HLS_PROXY_OBJS) $(LIBS)

clean:
	-rm -rf *.$(OBJ) $(ALL) core *.core *~ include/*~

install: $(HLS_PROXY)
	  install -d $(DESTDIR)$(PREFIX)/bin
	  install -m 755 $(HLS_PROXY) $(DESTDIR)$(PREFIX)/bin

##### Any additional, platform-specific rules come here:
