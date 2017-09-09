# repos/ dir must exist before running this.
SHELL=bash -e
GIT_CLONE=git clone --depth=1
SAT=repos/pypeFLOW repos/FALCON repos/FALCON-polish repos/FALCON-pbsmrtpipe repos/GenomicConsensus repos/pbalign repos/ConsensusCore repos/unanimity repos/pbcopper repos/pbbam repos/blasr repos/blasr_libcpp repos/DEXTRACTOR repos/DAZZ_DB repos/DALIGNER repos/DAMASKER repos/pbtranscript repos/pbtranscript2 repos/pbcore repos/pbcoretools
SL=repos/pbcommand

all: repos/nim-falcon repos/seqan repos/bam2fastx repos/FALCON_unzip repos/minimap repos/cDNA_Cupcake ${SAT} ${SL}
#repos/unanimity:
#	cd repos && ${GIT_CLONE} --recursive https://github.com/PacificBiosciences/unanimity
repos/FALCON_unzip:
	cd repos && ${GIT_CLONE} git@github.com:PacificBiosciences/FALCON_unzip_private FALCON_unzip
repos/nim-falcon:
	cd repos && ${GIT_CLONE} -b dev git@github.com:bio-nim/nim-falcon && cd nim-falcon && git submodule update --init
repos/seqan:
	cd repos && ${GIT_CLONE} https://github.com/PacificBiosciences/seqan
repos/cDNA_Cupcake:
	cd repos && ${GIT_CLONE} https://github.com/Magdoll/cDNA_Cupcake
repos/minimap:
	#cd repos && ${GIT_CLONE} https://github.com/lh3/minimap
	cd repos && ${GIT_CLONE} git@github.com:PacificBiosciences/minimap

BASE=https://github.com/PacificBiosciences
BRANCH=develop
repos/cDNA_Cupcake: BRANCH=master BASE=https://github.com/Magdoll
repos/minimap:      BRANCH=master BASE=https://github.com/lh3
${SAT}: BASE=ssh://git@bitbucket.nanofluidics.com:7999/SAT
${SL}:  BASE=ssh://git@bitbucket.nanofluidics.com:7999/SL
repos/%:
	${GIT_CLONE} -b ${BRANCH} ${BASE}/$* && mv $* repos/

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
