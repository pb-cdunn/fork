set -vex
export BOOST_ROOT=${PREFIX}
export pbcopper_INCLUDE_DIRS=${PREFIX}/include
export PacBioBAM_INCLUDE_DIRS=${PREFIX}/include
export SEQAN_INCLUDE_DIRS=${PREFIX}/include
export pbcopper_LIBRARIES=${PREFIX}/lib
export PacBioBAM_LIBRARIES=${PREFIX}/lib
export SEQAN_LIBRARIES=${PREFIX}/lib
VERBOSE=1  pip install -v --no-deps --user .

# Old env-vars:
#	     CMAKE_COMMAND=$(CMAKE) \
#        Boost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
#              SWIG_COMMAND=$(shell . $(PREFIX)/setup-env.sh && which swig) \
#     pbcopper_INCLUDE_DIRS=$(PREFIX)/include \
#        pbcopper_LIBRARIES=$(PREFIX)/lib/libpbcopper.a \
