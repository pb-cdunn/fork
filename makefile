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

PIP_CACHE_DIR?=${PIP_CACHE}
# With that, we do not actually need to pass --cache-dir, but it does not hurt.

PIP         = LDSHARED="$(CC) -shared" AR="$(shell $(CC) --print-prog-name=ar)" $(PREFIX)/bin/pip --cache-dir $(PIP_CACHE_DIR)
PIP_INSTALL = $(PIP) install -v --upgrade --user

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
export PKG_CONFIG_PATH   := $(PREFIX)/lib/pkgconfig
export PIP_CACHE_DIR

REPOS=/home/UNIXHOME/cdunn/repo/bb

all: falcon_kit
falcon_kit:
	${PIP} wheel ${REPOS}/FALCON
