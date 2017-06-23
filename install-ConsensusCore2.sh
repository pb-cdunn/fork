set -vex
VERBOSE=1  pip install -v --no-deps --user .

# Old env-vars:
#	     CMAKE_COMMAND=$(CMAKE) \
#        Boost_INCLUDE_DIRS=$(BOOST_ROOT)/include \
#              SWIG_COMMAND=$(shell . $(PREFIX)/setup-env.sh && which swig) \
#     pbcopper_INCLUDE_DIRS=$(PREFIX)/include \
#        pbcopper_LIBRARIES=$(PREFIX)/lib/libpbcopper.a \
