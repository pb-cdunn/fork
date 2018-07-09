all: align polish pbt
align: blasr-install samtools-install
polish: nim-falcon-install ccs-install dextractor-install bam2fastx-install daligner-install dazzdb-install damasker-install
pbt: minimap-install

include env.mk

# Note: pkg-config may be available for these. But
# also note that our copies of the .pc files lack ${prefix}, so beware.
#  https://github.com/open-source-parsers/jsoncpp/commit/2f178f390fce67bcfd1868ad14daee9778a4f941
BOOST_ROOT=/usr/local
BOOST_ORIG=${BOOST_ROOT}
#HDF5_DIR=/usr/local/Cellar/hdf5@1.8/1.8.20
HTSLIB_ORIG=/mnt/software/h/htslib/1.8
#HTSLIB_ORIG=/usr/local
#ZLIB_ORIG=/mnt/software/z/zlib/1.2.8-cloudflare/centos6
ZLIB_ORIG=/mnt/software/z/zlib/1.2.11
# https://jira.pacificbiosciences.com/browse/TAG-1415
#ZLIB_ROOT=/usr/local/opt/zlib
#ZLIB_ORIG=${ZLIB_ROOT}

boost-headers-install:
	ln -sf ${BOOST_ORIG}/include/boost ${PREFIX}/include/
	touch done/$@
boost-install: boost-headers-install
	# TODO: Install only the ones we actually need.
	rsync -av ${BOOST_ORIG}/lib/ ${PREFIX}/lib
	touch done/$@
htslib-install: #zlib-install #pbbam-install # TEMPORARY, UNTIL DEREK UPGRADES HTSLIB
	#cd ${REPOS}/htslib && bash ${PFHOME}/install-htslib.sh
	rsync -av --delete  ${HTSLIB_ORIG}/include/htslib ${PREFIX}/include/
	rsync -av ${HTSLIB_ORIG}/lib/ ${PREFIX}/lib
	rsync -av ${HTSLIB_ORIG}/bin/ ${PREFIX}/bin
	touch done/$@
zlib-install: htslib-install # does not really depend, but not sure where actually needed yet
	rsync -av ${ZLIB_ORIG}/include/ ${PREFIX}/include/
	rsync -av ${ZLIB_ORIG}/lib/ ${PREFIX}/lib
	touch done/$@

# TODO: What uses this?
#BOOST_ROOT:=${PREFIX}
#export BOOST_ROOT

daligner-install: dazzdb-install
	cd ${REPOS}/DALIGNER && ${MAKE} all && ${MAKE} install
	touch done/$@
dazzdb-install:
	cd ${REPOS}/DAZZ_DB && ${MAKE} all && ${MAKE} install
	touch done/$@
damasker-install:
	cd ${REPOS}/DAMASKER && ${MAKE} all && ${MAKE} install
	touch done/$@
dextractor-install:
	cd ${REPOS}/DEXTRACTOR && ${MAKE} all && ${MAKE} install
	touch done/$@
bam2fastx-install: zlib-install htslib-install pbbam-install pbcopper-install
	cd ${REPOS}/bam2fastx && bash ${PFHOME}/install-bam2fastx.sh
	touch done/$@
samtools-install:
	#bash ${PFHOME}/install-samtools.sh
	touch done/$@
nim-falcon-install:
	cd ${REPOS}/nim-falcon && bash ${PFHOME}/install-nim-falcon.sh
	touch done/$@
blasr-install: pbbam-install hdf5-install boost-headers-install  #blasr_libcpp-install
	bash ${PFHOME}/install-blasr.sh
	touch done/$@
blasr_libcpp-install: pbbam-install hdf5-install boost-headers-install #googletest-install
	#cd ${REPOS}/blasr_libcpp && bash ${PFHOME}/install-blasr_libcpp.sh
	touch done/$@
googletest-install:
	bash ${PFHOME}/install-googletest.sh
hdf5-install:
	bash ${PFHOME}/install-hdf5.sh
	touch done/$@
pbbam-install: boost-headers-install htslib-install
	bash ${PFHOME}/install-pbbam.sh
	touch done/$@
pbcopper-install: boost-headers-install
	cd ${REPOS}/pbcopper && bash ${PFHOME}/install-pbcopper.sh
	touch done/$@
ccs-install: pbbam-install seqan-install htslib-install pbcopper-install pbbam-install boost-headers-install
	cd ${REPOS}/unanimity && bash ${PFHOME}/install-ccs.sh
	touch done/$@
seqan-install: zlib-install
	cd ${REPOS}/seqan && tar cf - include|tar xf - -C ${PREFIX}/
	touch done/$@
minimap-install: zlib-install
	cd ${REPOS}/minimap && bash ${PFHOME}/install-minimap.sh
	touch done/$@
