# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts hdf5

set -vex

python2.7 configure.py --shared PREFIX=${PREFIX} \
        LIBPBDATA_INC=${PREFIX}/include/pbdata \
        LIBPBIHDF_INC=${PREFIX}/include/hdf \
         LIBBLASR_INC=${PREFIX}/include/alignment \

make blasr
make -C utils

tar cf - blasr | tar xf - -C ${PREFIX}/bin/
(cd utils && tar cf - loadPulses pls2fasta sawriter | tar xf - -C ${PREFIX}/bin/ )
(cd utils && tar cf - samFilter samtoh5 samtom4 sdpMatcher toAfg | tar xf - -C ${PREFIX}/bin/ )
