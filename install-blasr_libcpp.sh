# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts hdf5

set -vex

LIB=/mnt/software/l/libblasr/develop/lib

cp -aL ${LIB}/lib* ${PREFIX}/lib

cd /mnt/software/l/libblasr/develop/include/libblasr
tar cf - `find alignment hdf pbdata \( -name '*.hpp' -or -name '*.h' \)` | tar xf - -C ${PREFIX}/include
cd -
