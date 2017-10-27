# Required vars: PREFIX DYLIB
# Required deps: z boost

set -vex
rm -rf _build
mkdir -p _build
cd _build

cmake \
          -Dpbcopper_build_shared=OFF \
          -Dpbcopper_build_tests=OFF \
          -Dpbcopper_build_docs=OFF \
          -DBoost_INCLUDE_DIRS=${PREFIX}/include \
    ..
make

rsync -av lib/libpbcopper.a ${PREFIX}/lib/
#rsync -av lib/libpbcopper.a lib/libpbcopper.so ${PREFIX}/lib/
#rsync -av ../include/pbcopper ${PREFIX}/include/
cd ..
ln -sf $(pwd)/include/pbcopper ${PREFIX}/include/
