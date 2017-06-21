GIT_CLONE=git clone --depth=1

all: repos/pypeFLOW repos/FALCON repos/FALCON-polish repos/FALCON-pbsmrtpipe repos/GenomicConsensus repos/pbcommand repos/pbcore repos/pbcoretools repos/pbalign repos/ConsensusCore
repos/%:
	cd repos; ${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sat/$*
repos/pbcommand:
	cd repos; ${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sl/pbcommand
