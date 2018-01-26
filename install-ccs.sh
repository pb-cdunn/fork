# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts seqan pbcopper

set -vex

#mkdir -p _build
#cd _build
#
#cmake \
#        -DUNY_build_tests=OFF \
#        -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
#        -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
#        -DBoost_INCLUDE_DIRS=${PREFIX}/include \
#        -DPacBioBAM_INCLUDE_DIRS=${PREFIX}/include \
#        -DPacBioBAM_LIBRARIES=${PREFIX}/lib/libpbbam.${DYLIB} \
#        -DHTSLIB_INCLUDE_DIRS=${PREFIX}/include \
#        -DHTSLIB_LIBRARIES=${PREFIX}/lib/libhts.a \
#        -DSEQAN_INCLUDE_DIRS=${PREFIX}/include \
#        -Dpbcopper_INCLUDE_DIRS=${PREFIX}/include \
#        -Dpbcopper_LIBRARIES=${PREFIX}/lib/libpbcopper.a \
#    ..
#
#make
#rsync -av ccs ${PREFIX}/bin/
##TODO: Ask MJ why he had "-ax".


#### Meson

i=shared
# shared/static
j=off
# off/on
    CURRENT_BUILD_DIR="build_libs=${i}_unity=${j}"
    CURRENT_CONFIG="with libs=${i^^} and unity=${j^^}"
#rm -rf ${CURRENT_BUILD_DIR}
mkdir -p ${CURRENT_BUILD_DIR}

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

    # 3. test
    #ninja -v -C "${CURRENT_BUILD_DIR}" test

    # 4. install
    DESTDIR=${PREFIX} ninja -v -C "${CURRENT_BUILD_DIR}" install
