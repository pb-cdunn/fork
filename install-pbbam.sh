# Required vars: PREFIX DYLIB
# Required deps: z boost hts

set -vex

M=/mnt/software/p/pbbam/develop
#rsync -av ${M}/bin/ ${PREFIX}/bin
rsync -av ${M}/lib/lib* ${PREFIX}/lib
#rsync external/htslib/lib* ${PREFIX}/lib
cd ..
ln -sf ${M}/include/pbbam ${PREFIX}/include/
#ln -sf $(pwd)/third-party/htslib/htslib/htslib ${PREFIX}/include/
#ln -sf $(pwd)/third-party/htslib/htslib/cram ${PREFIX}/include/
