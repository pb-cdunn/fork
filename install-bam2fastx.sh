# Required vars: PREFIX DYLIB
# Required deps: z boost hts

set -vex
#rm -rf _build
mkdir -p _build
cd _build

#-DCMAKE_C_COMPILER_LAUNCHER=ccache
#-DCMAKE_CXX_COMPILER_LAUNCHER=ccache
cmake \
              -DBAM2FASTX_build_tests=OFF \
              -DBoost_INCLUDE_DIRS=${PREFIX}/include \
              -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
              -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
              -DPacBioBAM_LIBRARIES=${PREFIX}/lib/libpbbam.${DYLIB} \
              -DHTSLIB_LIBRARIES=${PREFIX}/lib/libhts.a \
              -Dpbcopper_INCLUDE_DIRS=${PREFIX}/include \
              -Dpbcopper_LIBRARIES=${PREFIX}/lib/libpbcopper.a \
            ..
#cmake -L
make VERBOSE=1
rsync -av bam2fasta bam2fastq ${PREFIX}/bin
cd ..
