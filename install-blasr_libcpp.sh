# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts hdf5

set -vex
#mkdir -p _build
#cd _build

python2.7 configure.py PREFIX=${PREFIX}

make clean # rely on ccache
make libpbdata LDLIBS=-lpbbam
make libpbihdf
make libblasr

cp -aL alignment/libblasr.${DYLIB} ${PREFIX}/lib/
cp -aL hdf/libpbihdf.${DYLIB} ${PREFIX}/lib/
cp -aL pbdata/libpbdata.${DYLIB} ${PREFIX}/lib/
tar cf - `find alignment hdf pbdata \( -name '*.hpp' -or -name '*.h' \)` | tar xf - -C ${PREFIX}/include
