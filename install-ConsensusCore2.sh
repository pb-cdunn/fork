set -vex
export BOOST_ROOT=${PREFIX}
export pbcopper_INCLUDE_DIRS=${PREFIX}/include
#export PacBioBAM_INCLUDE_DIRS=${PREFIX}/include
#export HTSLIB_INCLUDE_DIRS=${PREFIX}/include
#export ZLIB_INCLUDE_DIRS=${PREFIX}/include
#export SEQAN_INCLUDE_DIRS=${PREFIX}/include

export pbcopper_LIBRARIES=${PREFIX}/lib/libpbcopper.so
#export PacBioBAM_LIBRARIES=${PREFIX}/lib/libpbbam.${DYLIB}
#export HTSLIB_LIBRARIES=${PREFIX}/lib/libhtslib.${DYLIB}
#export ZLIB_LIBRARIES=${PREFIX}/lib/libzlib.${DYLIB}
#export SEQAN_LIBRARIES=${PREFIX}/lib?

#VERBOSE=1  pip install -v --no-deps --user .

###LDFLAGS='-static-libstdc++' \
###CMAKE_BUILD_TYPE=ReleaseWithAssert \
###CMAKE_COMMAND=cmake \
###VERBOSE=1 \
###pip install --user --no-index --verbose .

	     CMAKE_COMMAND=cmake \
        Boost_INCLUDE_DIRS=${BOOST_ROOT}/include \
        SWIG_COMMAND=$(which swig) \
        pbcopper_INCLUDE_DIRS=${PREFIX}/include \
        pbcopper_LIBRARIES=${PREFIX}/lib/libpbcopper.so \
                   VERBOSE=1 \
        pip install --user --verbose --upgrade --no-deps .

#CMAKE_BUILD_TYPE=ReleaseWithAssert CMAKE_COMMAND=cmake VERBOSE=1 pip install --verbose --upgrade --no-deps .

# Old env-vars:
#	     CMAKE_COMMAND=$(CMAKE) \
#        Boost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
#              SWIG_COMMAND=$(shell . $(PREFIX)/setup-env.sh && which swig) \
#     pbcopper_INCLUDE_DIRS=$(PREFIX)/include \
#        pbcopper_LIBRARIES=$(PREFIX)/lib/libpbcopper.a \
