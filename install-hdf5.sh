# Required vars: PREFIX DYLIB

set -vex

HDF_ROOT=/mnt/software/h/hdf5-tools/1.8.19
rsync -av ${HDF_ROOT}/include/ ${PREFIX}/include/
rsync -av ${HDF_ROOT}/lib/lib*.so* ${PREFIX}/lib/

# If we want to build outside PB, we need to work on HDF5.
