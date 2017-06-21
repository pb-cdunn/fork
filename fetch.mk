GIT_CLONE=git clone --depth=1

all: repos/pypeFLOW repos/FALCON repos/FALCON-polish repos/FALCON-pbsmrtpipe repos/GenomicConsensus
repos/%:
	cd repos; ${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sat/$*
