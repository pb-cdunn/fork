# Required vars: PREFIX
# Required deps: nim/0.17.1

set -vex

cd src
make -j1 all

rsync *.exe ${PREFIX}/bin/
