# Required vars: PREFIX DYLIB BOOST_ROOT
# Required deps: z boost bam hts seqan pbcopper

set -vex
mkdir -p _build
cd _build

cmake \
          -Dpbcopper_build_tests=OFF \
          -DZLIB_INCLUDE_DIRS=${PREFIX}/include \
          -DZLIB_LIBRARIES=${PREFIX}/lib/libz.${DYLIB} \
          -DBoost_INCLUDE_DIRS=${PREFIX}/include \
    ..

make
rsync -av lib/libpbcopper.a ${PREFIX}/lib/
#rsync -av ../include/pbcopper ${PREFIX}/include/
cd ..
ln -sf $(pwd)/include/pbcopper ${PREFIX}/include/
