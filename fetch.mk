# repos/ dir must exist before running this.
SHELL=bash -e
GIT_CLONE=git clone --depth=1

all: repos/nim-falcon repos/pypeFLOW repos/FALCON repos/FALCON-polish repos/FALCON-pbsmrtpipe repos/GenomicConsensus repos/pbcommand repos/pbcore repos/pbcoretools repos/pbalign repos/ConsensusCore repos/unanimity repos/seqan repos/pbcopper repos/pbbam repos/blasr repos/blasr_libcpp repos/bam2fastx repos/DEXTRACTOR repos/DAZZ_DB repos/DALIGNER repos/DAMASKER repos/FALCON_unzip
#repos/pbcommand:
#	cd repos && ${GIT_CLONE} https://github.com/PacificBiosciences/pbcommand
#repos/unanimity:
#	cd repos && ${GIT_CLONE} --recursive https://github.com/PacificBiosciences/unanimity
repos/FALCON_unzip:
	cd repos && ${GIT_CLONE} git@github.com:PacificBiosciences/FALCON_unzip_private FALCON_unzip
repos/nim-falcon:
	cd repos && ${GIT_CLONE} -b dev git@github.com:bio-nim/nim-falcon && cd nim-falcon && git submodule update --init
repos/seqan:
	cd repos && ${GIT_CLONE} https://github.com/PacificBiosciences/seqan
repos/%:
	cd repos && ${GIT_CLONE} -b develop https://github.com/PacificBiosciences/$*
#repos/bam2fastx:
#	cd repos && ${GIT_CLONE} /home/UNIXHOME/cdunn/repo/bb/bam2fastx
#repos/DEXTRACTOR:
#	cd repos && ${GIT_CLONE} /home/UNIXHOME/cdunn/repo/bb/DEXTRACTOR
#repos/DALIGNER:
#	cd repos && ${GIT_CLONE} /home/UNIXHOME/cdunn/repo/bb/DALIGNER
#repos/DAZZ_DB:
#	cd repos && ${GIT_CLONE} /home/UNIXHOME/cdunn/repo/bb/DAZZ_DB
#repos/DAMASKER:
#	cd repos && ${GIT_CLONE} /home/UNIXHOME/cdunn/repo/bb/DAMASKER
