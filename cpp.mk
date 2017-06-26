all: polish
polish: ccs-install dextractor-install bam2fastx-install daligner-install dazzdb-install damasker-install

include env.mk

# Note: pkg-config may be available for these. But
# also note that our copies of the .pc files lack ${prefix}, so beware.
#  https://github.com/open-source-parsers/jsoncpp/commit/2f178f390fce67bcfd1868ad14daee9778a4f941
BOOST_ORIG=/mnt/software/b/boost/1.60
HTSLIB_ORIG=/mnt/software/h/htslib/1.3.1
ZLIB_ORIG=/mnt/software/z/zlib/1.2.8-cloudflare

boost-headers-install:
	ln -sf ${BOOST_ORIG}/include/boost ${PREFIX}/include/
	touch done/$@
boost-install: boost-headers-install
	# TODO: Install only the ones we actually need.
	rsync -av ${BOOST_ORIG}/lib/ ${PREFIX}/lib
	touch done/$@
htslib-install: pbbam-install # TEMPORARY, UNTIL DEREK UPGRADES HTSLIB
	#rsync -av --delete  ${HTSLIB_ORIG}/include/htslib ${PREFIX}/include/
	#rsync -av ${HTSLIB_ORIG}/lib/ ${PREFIX}/lib
	touch done/$@
zlib-install:
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
	bash ${PFHOME}/install-samtools.sh
	touch done/$@
blasr-install: blasr_libcpp-install
	cd ${REPOS}/blasr && bash ${PFHOME}/install-blasr.sh
	touch done/$@
blasr_libcpp-install: pbbam-install hdf5-install boost-headers-install
	cd ${REPOS}/blasr_libcpp && bash ${PFHOME}/install-blasr_libcpp.sh
	touch done/$@
hdf5-install:
	bash ${PFHOME}/install-hdf5.sh
	touch done/$@
pbbam-install: boost-headers-install #htslib-install RE_ADD LATER!!!
	cd ${REPOS}/pbbam && bash ${PFHOME}/install-pbbam.sh
	touch done/$@
pbcopper-install: boost-headers-install
	cd ${REPOS}/pbcopper && bash ${PFHOME}/install-pbcopper.sh
	touch done/$@
ccs-install: seqan-install htslib-install pbcopper-install pbbam-install boost-headers-install
	cd ${REPOS}/unanimity && bash ${PFHOME}/install-ccs.sh
	touch done/$@
seqan-install: zlib-install
	cd ${REPOS}/seqan && tar cf - include|tar xf - -C ${PREFIX}/
	touch done/$@
