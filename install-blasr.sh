# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts hdf5

set -vex

cd /mnt/software/b/blasr/develop/bin
rsync -av blasr sawriter ${PREFIX}/bin/
cd -

#tar cf - blasr | tar xf - -C ${PREFIX}/bin/
#(cd utils && tar cf - loadPulses pls2fasta sawriter | tar xf - -C ${PREFIX}/bin/ )
#(cd utils && tar cf - samFilter samtoh5 samtom4 sdpMatcher toAfg | tar xf - -C ${PREFIX}/bin/ )
