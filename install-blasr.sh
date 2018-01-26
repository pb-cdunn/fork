# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts hdf5

set -vex
echo ${LD_LIBRARY_PATH}

###rm -rf pbbam
###ln -s ../pbbam pbbam
###
###rm -rf libcpp
###ln -s ../blasr_libcpp libcpp
###
####python2.7 configure.py --shared PREFIX=${PREFIX} \
####        LIBPBDATA_INC=${PREFIX}/include/pbdata \
####        LIBPBIHDF_INC=${PREFIX}/include/hdf \
####         LIBBLASR_INC=${PREFIX}/include/alignment \
####         HDF5_LIB=${PREFIX}/lib
####
####make blasr
####make -C utils
###
###rm -rf build
###mkdir -p build
###cd build
###cmake \
###    -DCMAKE_BUILD_TYPE=ReleaseWithAssert \
###    -DHDF5_ROOT=$HDF5_DIR \
###    -DPacBioBAM_build_docs=OFF \
###        -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
###        -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
###        -DBoost_INCLUDE_DIRS=${PREFIX}/include \
###        -DPacBioBAM_INCLUDE_DIRS=${PREFIX}/include \
###        -DPacBioBAM_LIBRARIES=${PREFIX}/lib64/libpbbam.${DYLIB} \
###        -DHTSLIB_INCLUDE_DIRS=${PREFIX}/include \
###        -DHTSLIB_LIBRARIES=${PREFIX}/lib/libhts.a \
###    -GNinja \
###  ..
###
####sed -i -e 's@/-I@/ -I@g' build.ninja
###ninja -v
###find .
###rsync -av blasr sawriter ${PREFIX}/bin/
###cd ..
###
####tar cf - blasr | tar xf - -C ${PREFIX}/bin/
####(cd utils && tar cf - loadPulses pls2fasta sawriter | tar xf - -C ${PREFIX}/bin/ )
####(cd utils && tar cf - samFilter samtoh5 samtom4 sdpMatcher toAfg | tar xf - -C ${PREFIX}/bin/ )




echo ${PREFIX}

i=shared
# shared/static
j=off
# off/on
    CURRENT_BUILD_DIR="build_libs=${i}_unity=${j}"
    CURRENT_CONFIG="with libs=${i^^} and unity=${j^^}"
#rm -rf ${CURRENT_BUILD_DIR}
mkdir -p ${CURRENT_BUILD_DIR}
    mkdir -p ${CURRENT_BUILD_DIR}/test-reports

    echo "======================"
    echo "Current configuration:"
    echo "  Libs:  ${i^^}"
    echo "  Unity: ${j^^}"
    echo "======================"
    meson \
      --prefix=${PREFIX} \
      --wrap-mode nofallback \
      --default-library "${i}" \
      --unity "${j}" \
      "${CURRENT_BUILD_DIR}" .

    # 2. build
    ninja -v -C "${CURRENT_BUILD_DIR}"

    # 3. tests
    #ninja -v -C "${CURRENT_BUILD_DIR}" test

    # 4. install
    ninja -v -C "${CURRENT_BUILD_DIR}" install
