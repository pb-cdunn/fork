# Required vars: PREFIX DYLIB
# Required deps: z boost pbbam hts seqan pbcopper

set -vex
mkdir -p _build
cd _build

cmake \
        -DUNY_build_tests=OFF \
        -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
        -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
        -DBoost_INCLUDE_DIRS=${PREFIX}/include \
        -DPacBioBAM_INCLUDE_DIRS=${PREFIX}/include \
        -DPacBioBAM_LIBRARIES=${PREFIX}/lib/libpbbam.${DYLIB} \
        -DHTSLIB_INCLUDE_DIRS=${PREFIX}/include \
        -DHTSLIB_LIBRARIES=${PREFIX}/lib/libhts.${DYLIB} \
        -DSEQAN_INCLUDE_DIRS=${PREFIX}/include \
        -Dpbcopper_INCLUDE_DIRS=${PREFIX}/include \
        -Dpbcopper_LIBRARIES=${PREFIX}/lib/libpbcopper.a \
    ..

make
rsync -av ccs ${PREFIX}/bin/
#TODO: Ask MJ why he had "-ax".
