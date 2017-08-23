source /mnt/software/Modules/current/init/bash
module purge
module load git
module load python/2.7.13-UCS2
module load ninja
module load gcc/6.4.0
module load cmake
module load swig
module load ccache
module load nim/0.17.0

module load zlib/1.2.11
module load gtest/1.8.0_p20170819
module load boost/1.60
module load htslib/1.5

#module load hdf5-tools/1.8.16
#module load openblas # so ConsensusCore can use numpy

#module load zlib # IMPORTANT: Do NOT load this!
