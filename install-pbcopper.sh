# Required vars: PREFIX DYLIB
# Required deps: z boost

set -vex

M=/mnt/software/p/pbcopper/develop
#rsync -av ${M}/bin/ ${PREFIX}/bin
rsync -av ${M}/lib/lib* ${PREFIX}/lib
ln -sf ${M}/include/pbcopper ${PREFIX}/include/
