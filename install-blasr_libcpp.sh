# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts hdf5

set -vex

###rm -rf pbbam
###ln -s ../pbbam .
###
####python2.7 configure.py PREFIX=${PREFIX}
###
####make clean # rely on ccache
####make libpbdata LDLIBS=-lpbbam
####make libpbihdf
####make libblasr
###
###DISTFILES_URL=http://nexus/repository/unsupported/distfiles
###curl -sL $DISTFILES_URL/googletest/release-1.8.0.tar.gz \
###| tar zxf - --strip-components 1 -C googletest
###
###mkdir -p build
###rm -rf build/*
###cd build
###
###CMAKE_BUILD_TYPE=ReleaseWithAssert cmake -GNinja -DPacBioBAM_build_docs=OFF -DHDF5_ROOT=$HDF5_DIR ..
###
###ninja
###
###cd ..
###
###cp -aL build/liblibcpp.a ${PREFIX}/lib
####cp -aL alignment/libblasr.${DYLIB} ${PREFIX}/lib/
####cp -aL hdf/libpbihdf.${DYLIB} ${PREFIX}/lib/
####cp -aL pbdata/libpbdata.${DYLIB} ${PREFIX}/lib/
###tar cf - `find alignment hdf pbdata \( -name '*.hpp' -or -name '*.h' \)` | tar xf - -C ${PREFIX}/include


export LDFLAGS="-lrt"
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
