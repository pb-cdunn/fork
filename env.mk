PFHOME:=$(shell pwd)
SHELL     = /bin/bash -e
CC        = gcc
CXX       = g++
FC        = gfortran
AR        = ar
GIT       = git
SED       = sed
CURL      = curl
CMAKE     = cmake
UNAME     = uname
MD5SUM    = md5sum
SHA1SUM   = sha1sum
PERL      = perl

CCACHE_DIR ?= $(PFHOME)/.git/ccache
CCACHE_BASEDIR := $(PFHOME)


ARCH      := $(shell $(UNAME) -m)
OPSYS     := $(shell $(UNAME) -s)

CFLAGS  =
LDFLAGS =

ifeq ($(OPSYS),Darwin)

CFLAGS    += -fPIC -I$(PREFIX)/include
LDFLAGS   += -L$(PREFIX)/lib

else ifeq ($(shell echo $(CC)|grep gcc>&/dev/null&&echo yes||true),yes)

CFLAGS    += -fPIC -I$(PREFIX)/include -D_GNU_SOURCE
LDFLAGS   += -L$(PREFIX)/lib -L$(PREFIX)/lib64 -static-libstdc++

else

CFLAGS    += -fPIC -I$(PREFIX)/include
LDFLAGS   += -L$(PREFIX)/lib -L$(PREFIX)/lib64

endif

CXXFLAGS  += $(CFLAGS)


ifeq ($(OPSYS),Darwin)

#HAVE_PYTHON ?= /usr/bin/python
#HAVE_ZLIB ?= /usr
DYLIB:=dylib
DYLD_LIBRARY_PATH:=$(PREFIX)/lib:${DYLD_LIBRARY_PATH}
export DYLD_LIBRARY_PATH
export DYLIB

else

DYLIB:=so
LD_LIBRARY_PATH:=$(PREFIX)/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH
export DYLIB

endif



export CC
export CXX
export FC
export CFLAGS
export LDFLAGS
export CXXFLAGS
export CCACHE_BASEDIR
export CCACHE_DIR
export SCCACHE_DIR
export PATH              := $(PREFIX)/bin:$(PFHOME)/bin:${PATH}
export PKG_CONFIG_PATH   := $(PREFIX)/lib/pkgconfig:${PKG_CONFIG_PATH}

REPOS=/home/UNIXHOME/cdunn/repo/bb
REPOS=repos

VPATH=.:done
