# Required vars: PREFIX
# Required deps: nim/0.17.1

set -vex

cd src
make all

rsync *.exe ${PREFIX}/bin/
