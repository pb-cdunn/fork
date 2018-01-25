type module >& /dev/null || . /mnt/software/Modules/current/init/bash
module purge

################
# DEPENDENCIES #
################

module load meson

#export PATH=/mnt/software/a/anaconda2/4.2.0/bin:$PATH
# Anaconda does not work with gcc/6.
module load python/2.7.14-UCS${UCS-4}

# buildsystem dependencies
module load ninja

module load gcc/6.4.0
module load swig
#module load gcc/5.3.0 # problem with our HDF5 now
module load ccache
module load git
module load cmake
module load nim/0.17.2

module load zlib
module load htslib
module load gtest
module load boost
module load hdf5-tools
module load cram
module load samtools
#module load openblas # so ConsensusCore can use numpy

#module load mummer/4.0.0
#module load doxygen

# remove trailing "/include", because CMake is brain-damaged
BOOST_ROOT=${BOOST_ROOT%/include}
# unset these variables to have meson discover all
# boost-dependent variables from BOOST_ROOT alone
unset BOOST_INCLUDEDIR
unset BOOST_LIBRARYDIR

#[[ $USER == "bamboo" ]] && export CCACHE_DIR=/mnt/secondary/Share/tmp/bamboo.mobs.ccachedir || true
