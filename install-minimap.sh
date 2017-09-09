# Required deps: z
set -vex

LDFLAGS=-L${PREFIX}/lib CPPFLAGS=-I${PREFIX}/include make -j minimap
rsync -av minimap ${PREFIX}/bin/minimap
