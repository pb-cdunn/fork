# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts hdf5

set -vex

rm -rf pbbam
ln -s ../pbbam pbbam

rm -rf libcpp
ln -s ../blasr_libcpp libcpp

#python2.7 configure.py --shared PREFIX=${PREFIX} \
#        LIBPBDATA_INC=${PREFIX}/include/pbdata \
#        LIBPBIHDF_INC=${PREFIX}/include/hdf \
#         LIBBLASR_INC=${PREFIX}/include/alignment \
#         HDF5_LIB=${PREFIX}/lib
#
#make blasr
#make -C utils

rm -rf build
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=ReleaseWithAssert \
    -DHDF5_ROOT=$HDF5_DIR \
    -DPacBioBAM_build_docs=OFF \
        -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
        -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
        -DBoost_INCLUDE_DIRS=${PREFIX}/include \
        -DPacBioBAM_INCLUDE_DIRS=${PREFIX}/include \
        -DPacBioBAM_LIBRARIES=${PREFIX}/lib/libpbbam.${DYLIB} \
        -DHTSLIB_INCLUDE_DIRS=${PREFIX}/include \
        -DHTSLIB_LIBRARIES=${PREFIX}/lib/libhts.a \
    -GNinja \
  ..

#sed -i -e 's@/-I@/ -I@g' build.ninja
ninja
find .
cd ..

#tar cf - blasr | tar xf - -C ${PREFIX}/bin/
#(cd utils && tar cf - loadPulses pls2fasta sawriter | tar xf - -C ${PREFIX}/bin/ )
#(cd utils && tar cf - samFilter samtoh5 samtom4 sdpMatcher toAfg | tar xf - -C ${PREFIX}/bin/ )
