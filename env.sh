#PFHOME=/scratch/cdunn/pitchfork
PFHOME=$(pwd)
PREFIX=${PFHOME}/.git/LOCAL${UCS-4}
PYTHONUSERBASE=${PREFIX}
PATH=${PREFIX}/bin:${PATH}:/usr/local/mummer
LD_LIBRARY_PATH=${PREFIX}/lib:${LD_LIBRARY_PATH}
DYLD_LIBRARY_PATH=${PREFIX}/lib:${DYLD_LIBRARY_PATH}:/usr/local/lib
export PFHOME PREFIX PYTHONUSERBASE PATH LD_LIBRARY_PATH DYLD_LIBRARY_PATH

# not sure, but this might affect cmake
export DEBUG=1
