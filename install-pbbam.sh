# Required vars: PREFIX DYLIB
# Required deps: z boost hts

set -vex

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
      -Denable-build-tools=true \
      -Denable-tests=true \
      "${CURRENT_BUILD_DIR}" .

    # -Denable-tests=false -- Possibly this will not need gtest anymore.

    # 2. build
    ninja -v -C "${CURRENT_BUILD_DIR}"

    # 3. tests
    GTEST_OUTPUT="xml:${CURRENT_BUILD_DIR}/test-reports/pbbam_results.xml" ARGS=-V VERBOSE=1 \
    ninja -v -C "${CURRENT_BUILD_DIR}" test
    #cram --xunit-file=${CURRENT_BUILD_DIR}/test-reports/pbbam_cramunit.xml ${CURRENT_BUILD_DIR}/tools

    ninja -v -C "${CURRENT_BUILD_DIR}" install

#            -DGTEST_SRC_DIR=$(pwd)/gtest-1.7.0 \
#cmake \
#            -DPacBioBAM_build_shared=ON \
#            -DPacBioBAM_build_docs=OFF \
#            -DPacBioBAM_build_tests=OFF \
#            -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
#            -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
#            -DBoost_INCLUDE_DIRS=${PREFIX}/include \
#            -DCMAKE_BUILD_TYPE=RelWithDebInfo \
#            -DCMAKE_SKIP_BUILD_RPATH=FALSE \
#            ..
#make VERBOSE=1

##cd ${CURRENT_BUILD_DIR}
##rsync -av bin/ ${PREFIX}/bin
##rsync -av lib/lib* ${PREFIX}/lib
###rsync external/htslib/lib* ${PREFIX}/lib
##cd ..
##ln -sf $(pwd)/include/pbbam ${PREFIX}/include/
#ln -sf $(pwd)/third-party/htslib/htslib/htslib ${PREFIX}/include/
#ln -sf $(pwd)/third-party/htslib/htslib/cram ${PREFIX}/include/
