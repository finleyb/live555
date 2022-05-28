INCLUDES = -Iinclude -I../groupsock/include
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

NAME = libUsageEnvironment
USAGE_ENVIRONMENT_LIB = $(NAME).$(LIB_SUFFIX)
ALL = $(USAGE_ENVIRONMENT_LIB)
all:	$(ALL)

OBJS = UsageEnvironment.$(OBJ) HashTable.$(OBJ) strDup.$(OBJ)

$(USAGE_ENVIRONMENT_LIB): $(OBJS)
	$(LIBRARY_LINK)$@ $(LIBRARY_LINK_OPTS) $(OBJS)

.$(C).$(OBJ):
	$(C_COMPILER) -c $(C_FLAGS) $<       

.$(CPP).$(OBJ):
	$(CPLUSPLUS_COMPILER) -c $(CPLUSPLUS_FLAGS) $<

UsageEnvironment.$(CPP):	include/UsageEnvironment.hh
include/UsageEnvironment.hh:	include/UsageEnvironment_version.hh include/Boolean.hh include/strDup.hh
HashTable.$(CPP):		include/HashTable.hh
include/HashTable.hh:		include/Boolean.hh
strDup.$(CPP):			include/strDup.hh

clean:
	-rm -rf *.$(OBJ) $(ALL) core *.core *~ include/*~

install: install1 $(INSTALL2)
install1: $(USAGE_ENVIRONMENT_LIB)
	  install -d $(DESTDIR)$(PREFIX)/include/UsageEnvironment $(DESTDIR)$(LIBDIR)
	  install -m 644 include/*.hh $(DESTDIR)$(PREFIX)/include/UsageEnvironment
	  install -m 644 $(USAGE_ENVIRONMENT_LIB) $(DESTDIR)$(LIBDIR)
install_shared_libraries: $(USAGE_ENVIRONMENT_LIB)
	  ln -fs $(NAME).$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/$(NAME).$(SHORT_LIB_SUFFIX)
	  ln -fs $(NAME).$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/$(NAME).so

##### Any additional, platform-specific rules come here:
