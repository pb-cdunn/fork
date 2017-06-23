# Required vars: PREFIX DYLIB BOOST_ROOT
# Required deps: z boost hts

set -vex
#rm -rf _build
mkdir -p _build
cd _build

cmake \
            -DPacBioBAM_build_shared=ON \
            -DPacBioBAM_build_docs=OFF \
            -DPacBioBAM_build_tests=OFF \
            -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
            -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
            -DBoost_INCLUDE_DIRS=${PREFIX}/include \
            -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DCMAKE_SKIP_BUILD_RPATH=FALSE \
            ..
#cmake -L
make VERBOSE=1
rsync -av bin/ ${PREFIX}/bin
rsync -av lib/ ${PREFIX}/lib
ln -sf include/pbbam ${PREFIX}/include/
ln -sf repos/pbbam/third-party/htslib/htslib/htslib ${PREFIX}/include/
ln -sf repos/pbbam/third-party/htslib/htslib/cram ${PREFIX}/include/
