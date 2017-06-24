# Be sure to source env.sh before using this makefile.

all: # default rule

setup:
	mkdir -p ${PREFIX}/include
	mkdir -p ${PREFIX}/lib
	mkdir -p ${PREFIX}/bin
	mkdir -p done/
	${MAKE} install-pip

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
export PKG_CONFIG_PATH   := $(PREFIX)/lib/pkgconfig
export PIP_CACHE_DIR

REPOS=/home/UNIXHOME/cdunn/repo/bb
REPOS=repos
WHEEL_DIR=${PFHOME}/wheels
DIST_DIR=${PFHOME}/dist
# Not sure what BDIST_DIR does. Any effect?
BDIST_DIR=${PFHOME}/bdist
VPATH=.:done

# Note: pkg-config may be available for these. But
# also note that our copies of the .pc files lack ${prefix}, so beware.
#  https://github.com/open-source-parsers/jsoncpp/commit/2f178f390fce67bcfd1868ad14daee9778a4f941
BOOST_ORIG=/mnt/software/b/boost/1.60
HTSLIB_ORIG=/mnt/software/h/htslib/1.3.1
ZLIB_ORIG=/mnt/software/z/zlib/1.2.8-cloudflare

boost-headers-install:
	ln -sf ${BOOST_ORIG}/include/boost ${PREFIX}/include/
	touch done/$@
boost-install: boost-headers-install
	# TODO: Install only the ones we actually need.
	rsync -av ${BOOST_ORIG}/lib/ ${PREFIX}/lib
	touch done/$@
htslib-install: pbbam-install # TEMPORARY, UNTIL DEREK UPGRADES HTSLIB
	#rsync -av --delete  ${HTSLIB_ORIG}/include/htslib ${PREFIX}/include/
	#rsync -av ${HTSLIB_ORIG}/lib/ ${PREFIX}/lib
	touch done/$@
zlib-install:
	rsync -av ${ZLIB_ORIG}/include/ ${PREFIX}/include/
	rsync -av ${ZLIB_ORIG}/lib/ ${PREFIX}/lib
	touch done/$@

# TODO: What uses this?
#BOOST_ROOT:=${PREFIX}
#export BOOST_ROOT


all: basic sl polish FALCON_unzip-pip
polish: gc cc cc2 ccs pbalign-pip dextractor-install bam2fastx-install
basic: FALCON-pip pypeFLOW-pip FALCON-polish-pip FALCON-pbsmrtpipe-pip
cc2: ConsensusCore2-pip
ccs: ccs-install
dextractor-install:
bam2fastx-install:
pbalign-pip: pbcore-pip pbcommand-pip samtools-install blasr-install
samtools-install:
	bash ${PFHOME}/install-samtools.sh
	touch done/$@
blasr-install: blasr_libcpp-install
	cd ${REPOS}/blasr && bash ${PFHOME}/install-blasr.sh
	touch done/$@
blasr_libcpp-install: pbbam-install hdf5-install boost-headers-install
	cd ${REPOS}/blasr_libcpp && bash ${PFHOME}/install-blasr_libcpp.sh
	touch done/$@
hdf5-install:
	bash ${PFHOME}/install-hdf5.sh
	touch done/$@
pbbam-install: boost-headers-install #htslib-install RE_ADD LATER!!!
	cd ${REPOS}/pbbam && bash ${PFHOME}/install-pbbam.sh
	touch done/$@
pbcopper-install: boost-headers-install
	cd ${REPOS}/pbcopper && bash ${PFHOME}/install-pbcopper.sh
	touch done/$@
ccs-install: seqan-install htslib-install pbcopper-install pbbam-install boost-headers-install
	cd ${REPOS}/unanimity && bash ${PFHOME}/install-ccs.sh
	touch done/$@
seqan-install: zlib-install
	cd ${REPOS}/seqan && tar cf - include|tar xf - -C ${PREFIX}/
	touch done/$@
ConsensusCore2-pip:
	cd ${REPOS}/unanimity && bash ${PFHOME}/install-ConsensusCore2.sh
	touch done/$@
gc:GenomicConsensus-pip
sl: pbcommand-pip pbcore-pip pbcoretools-pip pbalign-pip
cc: ConsensusCore-pip
ConsensusCore-pip: numpy-pip boost-headers-install
	cd ${REPOS}/ConsensusCore && bash ${PFHOME}/install-ConsensusCore.sh
	touch done/$@
numpy-pip:
	pip install --user numpy
	touch done/$@
GenomicConsensus-pip: ConsensusCore-pip
%-pip:
	cd ${REPOS}/$*; rm -rf build/
	cd ${REPOS}/$*; pip install -v --no-deps --user .
	touch done/$@
fetch:
	${MAKE} -f fetch.mk
install-pip:
	python2.7 get-pip.py --user
	touch done/$@

# NOT USED
%-whl:
	cd ${REPOS}/$*; rm -rf build/
	cd ${REPOS}/$*; python2.7 setup.py -v --no-user-cfg bdist_wheel --bdist-dir ${BDIST_DIR} --dist-dir ${DIST_DIR}
	touch done/$@
