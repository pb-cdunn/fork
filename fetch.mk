# repos/ dir must exist before running this.
SHELL=bash -e
GIT_CLONE=git clone --depth=1
SAT=repos/pypeFLOW repos/FALCON repos/FALCON_unzip_private repos/FALCON-polish repos/FALCON-pbsmrtpipe repos/GenomicConsensus repos/pbalign repos/ConsensusCore repos/unanimity repos/pbcopper repos/pbbam repos/blasr repos/blasr_libcpp repos/DEXTRACTOR repos/DAZZ_DB repos/DALIGNER repos/DAMASKER repos/pbtranscript repos/pbcore repos/pbcoretools repos/htslib #repos/pbtranscript2
SL=repos/pbcommand

all: repos/nim-falcon repos/seqan repos/bam2fastx repos/minimap repos/cDNA_Cupcake ${SAT} ${SL}

repos/nim-falcon:   BRANCH=dev
repos/seqan:        BRANCH=master
repos/cDNA_Cupcake: BRANCH=master
repos/minimap:      BRANCH=master

repos/cDNA_Cupcake: BASE=git@github.com:/Magdoll
repos/minimap:      BASE=https://github.com/lh3
repos/nim-falcon:   BASE=git@github.com:bio-nim
repos/htslib:	    BASE=https://github.com/samtools

BASE=git@github.com:PacificBiosciences
BRANCH=develop
#${SAT}: BASE=ssh://git@bitbucket.nanofluidics.com:7999/SAT
#${SL}:  BASE=ssh://git@bitbucket.nanofluidics.com:7999/SL
repos/%:
	${GIT_CLONE} -b ${BRANCH} --recursive ${BASE}/$* && mv $* repos/
