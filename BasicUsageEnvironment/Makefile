INCLUDES = -Iinclude -I../UsageEnvironment/include -I../groupsock/include
PREFIX = /usr/local
LIBDIR = $(PREFIX)/lib
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

NAME = libBasicUsageEnvironment
LIB_FILE = $(NAME).$(LIB_SUFFIX)
ALL = $(LIB_FILE)
all:	$(ALL)

OBJS = BasicUsageEnvironment0.$(OBJ) BasicUsageEnvironment.$(OBJ) \
	BasicTaskScheduler0.$(OBJ) BasicTaskScheduler.$(OBJ) \
	DelayQueue.$(OBJ) BasicHashTable.$(OBJ)

libBasicUsageEnvironment.$(LIB_SUFFIX): $(OBJS)
	$(LIBRARY_LINK)$@ $(LIBRARY_LINK_OPTS) \
		$(OBJS)

.$(C).$(OBJ):
	$(C_COMPILER) -c $(C_FLAGS) $<       

.$(CPP).$(OBJ):
	$(CPLUSPLUS_COMPILER) -c $(CPLUSPLUS_FLAGS) $<

BasicUsageEnvironment0.$(CPP):	include/BasicUsageEnvironment0.hh
include/BasicUsageEnvironment0.hh:	include/BasicUsageEnvironment_version.hh include/DelayQueue.hh
BasicUsageEnvironment.$(CPP):	include/BasicUsageEnvironment.hh
include/BasicUsageEnvironment.hh:	include/BasicUsageEnvironment0.hh
BasicTaskScheduler0.$(CPP):	include/BasicUsageEnvironment0.hh include/HandlerSet.hh
BasicTaskScheduler.$(CPP):	include/BasicUsageEnvironment.hh include/HandlerSet.hh
DelayQueue.$(CPP):		include/DelayQueue.hh
BasicHashTable.$(CPP):		include/BasicHashTable.hh

clean:
	-rm -rf *.$(OBJ) $(ALL) core *.core *~ include/*~

install: install1 $(INSTALL2)
install1: libBasicUsageEnvironment.$(LIB_SUFFIX)
	  install -d $(DESTDIR)$(PREFIX)/include/BasicUsageEnvironment $(DESTDIR)$(LIBDIR)
	  install -m 644 include/*.hh $(DESTDIR)$(PREFIX)/include/BasicUsageEnvironment
	  install -m 644 libBasicUsageEnvironment.$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)
install_shared_libraries: libBasicUsageEnvironment.$(LIB_SUFFIX)
	  ln -fs $(NAME).$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/$(NAME).$(SHORT_LIB_SUFFIX)
	  ln -fs $(NAME).$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/$(NAME).so

##### Any additional, platform-specific rules come here:
