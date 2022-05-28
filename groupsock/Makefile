INCLUDES = -Iinclude -I../UsageEnvironment/include
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

NAME = libgroupsock
ALL = $(NAME).$(LIB_SUFFIX)
all:	$(ALL)

.$(C).$(OBJ):
	$(C_COMPILER) -c $(C_FLAGS) $<
.$(CPP).$(OBJ):
	$(CPLUSPLUS_COMPILER) -c $(CPLUSPLUS_FLAGS) $<

GROUPSOCK_LIB_OBJS = GroupsockHelper.$(OBJ) GroupEId.$(OBJ) inet.$(OBJ) Groupsock.$(OBJ) NetInterface.$(OBJ) NetAddress.$(OBJ) IOHandlers.$(OBJ)

GroupsockHelper.$(CPP):	include/GroupsockHelper.hh
include/GroupsockHelper.hh:	include/NetAddress.hh
include/NetAddress.hh:	include/NetCommon.h
GroupEId.$(CPP):	include/GroupEId.hh
include/GroupEId.hh:	include/NetAddress.hh
inet.$(C):		include/NetCommon.h
Groupsock.$(CPP):	include/Groupsock.hh include/GroupsockHelper.hh
include/Groupsock.hh:	include/groupsock_version.hh include/NetInterface.hh include/GroupEId.hh
include/NetInterface.hh:	include/NetAddress.hh
NetInterface.$(CPP):	include/NetInterface.hh include/GroupsockHelper.hh
NetAddress.$(CPP):	include/NetAddress.hh include/GroupsockHelper.hh
IOHandlers.$(CPP):	include/IOHandlers.hh

libgroupsock.$(LIB_SUFFIX): $(GROUPSOCK_LIB_OBJS) \
    $(PLATFORM_SPECIFIC_LIB_OBJS)
	$(LIBRARY_LINK)$@ $(LIBRARY_LINK_OPTS) \
		$(GROUPSOCK_LIB_OBJS)

clean:
	-rm -rf *.$(OBJ) $(ALL) core *.core *~ include/*~

install: install1 $(INSTALL2)
install1: libgroupsock.$(LIB_SUFFIX)
	  install -d $(DESTDIR)$(PREFIX)/include/groupsock $(DESTDIR)$(LIBDIR)
	  install -m 644 include/*.hh include/*.h $(DESTDIR)$(PREFIX)/include/groupsock
	  install -m 644 libgroupsock.$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)
install_shared_libraries: libgroupsock.$(LIB_SUFFIX)
	  ln -fs libgroupsock.$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/libgroupsock.$(SHORT_LIB_SUFFIX)
	  ln -fs libgroupsock.$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/libgroupsock.so

##### Any additional, platform-specific rules come here:
