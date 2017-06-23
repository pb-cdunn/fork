# Required var: PREFIX DYLIB BOOST_ROOT
# Required deps: z boost bam hts seqan pbcopper
set -vex
mkdir -p _build
cd _build

if [ -e ${PREFIX}/lib/libpbbam.${DYLIB} ]; then
    PacBioBAM_LIBRARIES=${PREFIX}/lib/libpbbam.${DYLIB}
else
    PacBioBAM_LIBRARIES=${PREFIX}/lib/libpbbam.a
fi

cmake \
        -DUNY_build_tests=OFF \
        -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
        -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
        -DBoost_INCLUDE_DIRS=${BOOST_ROOT}/include \
        -DPacBioBAM_INCLUDE_DIRS=${PREFIX}/include \
        -DPacBioBAM_LIBRARIES=${PacBioBAM_LIBRARIES} \
        -DHTSLIB_INCLUDE_DIRS=${PREFIX}/src/htslib/include \
        -DHTSLIB_LIBRARIES=${PREFIX}/src/htslib/lib/libhts.a \
        -DSEQAN_INCLUDE_DIRS=${PREFIX}/include \
        -Dpbcopper_INCLUDE_DIRS=${PREFIX}/include \
        -Dpbcopper_LIBRARIES=${PREFIX}/lib/libpbcopper.a \
    ..
${MAKE}
rsync -ax ccs ${PREFIX}/bin/
