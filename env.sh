source /mnt/software/Modules/current/init/bash
module purge
module load git
module load python
module load gcc/4.9.2
module load cmake

module load ccache
#module load boost
#module load hdf5-tools/1.8.16
#module load openblas # so ConsensusCore can use numpy

#module load zlib # IMPORTANT: Do NOT load this!

set -vex

PFHOME=/scratch/cdunn/pitchfork
PREFIX=/scratch/cdunn/pu
PYTHONUSERBASE=${PREFIX}
export PFHOME PREFIX PYTHONUSERBASE
