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

PIP_CACHE:=${PFHOME}/.git/pip
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


ifeq ($(OPSYS),Darwin)

#HAVE_PYTHON ?= /usr/bin/python
#HAVE_ZLIB ?= /usr
DYLIB:=dylib
DYLD_LIBRARY_PATH:=$(PREFIX)/lib:${DYLD_LIBRARY_PATH}
export DYLD_LIBRARY_PATH

else

DYLIB:=so
LD_LIBRARY_PATH:=$(PREFIX)/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

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
export PKG_CONFIG_PATH   := $(PREFIX)/lib/pkgconfig
export PIP_CACHE_DIR

REPOS=/home/UNIXHOME/cdunn/repo/bb
REPOS=repos
WHEEL_DIR=${PFHOME}/wheels
DIST_DIR=${PFHOME}/dist
# Not sure what BDIST_DIR does. Any effect?
BDIST_DIR=${PFHOME}/bdist
VPATH=.:done

BOOST_ROOT=/mnt/software/b/boost/1.60
export BOOST_ROOT

all: basic gc sl cc cc2
basic: FALCON-pip pypeFLOW-pip FALCON-polish-pip FALCON-pbsmrtpipe-pip
cc2: ConsensusCore2-pip
ccs-install: seqan-install
	cd ${REPOS}/unanimity && bash ${PFHOME}/install-ccs.sh
	touch done/$@
seqan-install:
	cd ${REPOS}/seqan && tar cf - include|tar xf - -C ${PREFIX}/
	touch done/$@
foo:
	     CMAKE_COMMAND=$(CMAKE) \
        Boost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
              SWIG_COMMAND=$(shell . $(PREFIX)/setup-env.sh && which swig) \
     pbcopper_INCLUDE_DIRS=$(PREFIX)/include \
        pbcopper_LIBRARIES=$(PREFIX)/lib/libpbcopper.a \

ConsensusCore2-pip:
	cd ${REPOS}/unanimity; \
                   VERBOSE=1 \
        pip install -v --no-deps --user .
gc:GenomicConsensus-pip
sl: pbcommand-pip pbcore-pip pbcoretools-pip pbalign-pip
cc: ConsensusCore-pip
ConsensusCore-pip: numpy-pip
	#cd ${REPOS}/ConsensusCore; pip install -v --user --no-deps --install-option="--swig=$(PREFIX)/bin/swig" --install-option="--swig-lib=$(PREFIX)/share/swig/3.0.8" --install-option="--boost=$(BOOST_ROOT)/include" .
	cd ${REPOS}/ConsensusCore; python setup.py -v install --user --boost=$(BOOST_ROOT)/include
numpy-pip:
	pip install --user numpy
GenomicConsensus-pip: ConsensusCore-pip
install-pip:
	python2.7 get-pip.py --user
falcon_kit:
	#cd ${REPOS}/FALCON; python2.7 setup.py -v bdist_wheel -h
	cd ${REPOS}/FALCON; rm -rf build/
	#cd ${REPOS}/FALCON; python2.7 setup.py -v bdist_wheel
	cd ${REPOS}/FALCON; python2.7 setup.py -v --no-user-cfg bdist_wheel --bdist-dir ${BDIST_DIR} --dist-dir ${DIST_DIR}
%-whl:
	cd ${REPOS}/$*; rm -rf build/
	cd ${REPOS}/$*; python2.7 setup.py -v --no-user-cfg bdist_wheel --bdist-dir ${BDIST_DIR} --dist-dir ${DIST_DIR}
	touch done/$@
%-pip:
	cd ${REPOS}/$*; rm -rf build/
	cd ${REPOS}/$*; pip install -v --no-deps --user .
	touch done/$@
fetch:
	${MAKE} -f fetch.mk
