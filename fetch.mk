# repos/ dir must exist before running this.
SHELL=bash -e
GIT_CLONE=git clone --depth=1
SAT=repos/pypeFLOW repos/FALCON repos/FALCON-polish repos/FALCON-pbsmrtpipe repos/GenomicConsensus repos/pbalign repos/ConsensusCore repos/unanimity repos/pbcopper repos/pbbam repos/blasr repos/blasr_libcpp repos/DEXTRACTOR repos/DAZZ_DB repos/DALIGNER repos/DAMASKER repos/pbtranscript repos/pbtranscript2 repos/pbcore repos/pbcoretools
SL=repos/pbcommand

all: repos/nim-falcon repos/seqan repos/bam2fastx repos/FALCON_unzip repos/minimap repos/cDNA_Cupcake ${SAT} ${SL}

repos/nim-falcon: BRANCH=dev BASE=git@github.com:bio-nim/nim-falcon
	${GIT_CLONE} -b ${BRANCH} ${BASE}/$* && mv $* repos/
	cd $@; git submodule update --init

BASE=git@github.com:PacificBiosciences
BRANCH=develop
repos/cDNA_Cupcake: BRANCH=master BASE=git@github.com:/Magdoll
repos/minimap:      BRANCH=master BASE=https://github.com/lh3
#${SAT}: BASE=ssh://git@bitbucket.nanofluidics.com:7999/SAT
#${SL}:  BASE=ssh://git@bitbucket.nanofluidics.com:7999/SL
repos/%:
	${GIT_CLONE} -b ${BRANCH} ${BASE}/$* && mv $* repos/
