# repos/ dir must exist before running this.
SHELL=bash -e
GIT_CLONE=git clone --depth=1
SAT=repos/pypeFLOW repos/FALCON repos/FALCON_unzip_private repos/FALCON-polish repos/FALCON-pbsmrtpipe repos/GenomicConsensus repos/pbalign repos/ConsensusCore repos/unanimity repos/pbcopper repos/pbbam repos/DEXTRACTOR repos/DAZZ_DB repos/DALIGNER repos/DAMASKER repos/pbtranscript repos/pbcore repos/pbcoretools repos/pbsv #repos/pbtranscript2
SL=repos/pbcommand

all: repos/nim-falcon repos/seqan repos/bam2fastx repos/minimap repos/cDNA_Cupcake ${SAT} ${SL}

repos/nim-falcon:   BRANCH=dev
repos/seqan:        BRANCH=master
repos/cDNA_Cupcake: BRANCH=master
repos/minimap:      BRANCH=master

repos/cDNA_Cupcake: BASE=https://github.com/Magdoll
repos/minimap:      BASE=https://github.com/lh3
repos/nim-falcon:   BASE=https://github.com/bio-nim

BASE=https://github.com/PacificBiosciences
BRANCH=develop
${SAT}: BASE=http://bitbucket.nanofluidics.com:7990/scm/SAT
${SL}:  BASE=http://bitbucket.nanofluidics.com:7990/scm/SL
repos/%:
	${GIT_CLONE} -b ${BRANCH} --recursive ${BASE}/$*.git && mv $* repos/
