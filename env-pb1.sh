type module >& /dev/null || . /mnt/software/Modules/current/init/bash
################
# DEPENDENCIES #
################

# buildsystem dependencies
module load meson/0.41.1
module load ninja/1.7.2

module load gcc/6.4.0
#module load gcc/5.3.0 # problem with our HDF5 now
module load ccache/3.3.4
module load git/2.8.3
module load cmake
module load nim/0.17.1

module load zlib/1.2.11
module load htslib/1.5
module load gtest/1.8.0_p20170819
module load boost/1.60
module load hdf5-tools/1.8.16
module load cram/0.7

# remove trailing "/include", because CMake is brain-damaged
BOOST_ROOT=${BOOST_ROOT%/include}
# unset these variables to have meson discover all
# boost-dependent variables from BOOST_ROOT alone
unset BOOST_INCLUDEDIR
unset BOOST_LIBRARYDIR

#[[ $USER == "bamboo" ]] && export CCACHE_DIR=/mnt/secondary/Share/tmp/bamboo.mobs.ccachedir || true
