pushd repos
GIT_CLONE='git clone --depth=1'
${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sat/pypeFLOW
${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sat/FALCON
${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sat/FALCON-polish
${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sat/FALCON-pbsmrtpipe
${GIT_CLONE} ssh://git@bitbucket.nanofluidics.com:7999/sat/GenomicConsensus
popd
