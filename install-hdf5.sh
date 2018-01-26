# Required vars: PREFIX DYLIB

set -vex

echo HDF5_DIR=${HDF5_DIR}
rsync -av ${HDF5_DIR}/include/ ${PREFIX}/include/
rsync -av ${HDF5_DIR}/lib/lib* ${PREFIX}/lib/

# If we want to build outside PB, we need to work on HDF5.
