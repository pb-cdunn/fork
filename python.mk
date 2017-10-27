all: basic sl pbt ConsensusCore2-pip GenomicConsensus-pip FALCON_unzip_private-pip
pbt: pbtranscript2-pip pbtranscript-pip cDNA_Cupcake-pip
sl: pbcommand-pip pbcore-pip pbcoretools-pip pbalign-pip
basic: FALCON-pip pypeFLOW-pip FALCON-polish-pip FALCON-pbsmrtpipe-pip
pbalign-pip: pbcore-pip pbcommand-pip
GenomicConsensus-pip: pbcommand-pip pbcore-pip ConsensusCore-pip h5py-pypi

include env.mk

# We want to run everything here without -j because
# pip does not know about other pips.

.NOTPARALLEL:

PIP_CACHE:=${PFHOME}/.git/pip
PIP_CACHE_DIR?=${PIP_CACHE}
export PIP_CACHE_DIR
# With that, we do not actually need to pass --cache-dir, but it does not hurt.

PIP         = LDSHARED="$(CC) -shared" AR="$(shell $(CC) --print-prog-name=ar)" $(PREFIX)/bin/pip --cache-dir $(PIP_CACHE_DIR)
PIP_INSTALL = $(PIP) install -v --find-links=/home/cdunn/wheelhouse/gcc-6/

WHEEL_DIR=${PFHOME}/wheels
DIST_DIR=${PFHOME}/dist
# Not sure what BDIST_DIR does. Any effect?
BDIST_DIR=${PFHOME}/bdist


ConsensusCore2-pip:
	cd ${REPOS}/unanimity && bash ${PFHOME}/install-ConsensusCore2.sh
	touch done/$@
ConsensusCore-pip: #boost-headers-install
	cd ${REPOS}/ConsensusCore && bash ${PFHOME}/install-ConsensusCore.sh
	touch done/$@
GenomicConsensus-pip:
	python -c 'import ConsensusCore as c; print c'
	pip freeze | grep ConsensusCore
	cd ${REPOS}/GenomicConsensus && python setup.py install -v --user
	touch done/$@
h5py-pypi:
	${PIP_INSTALL} -v --user h5py==2.4.0
	touch done/$@

install-pip:
	python2.7 get-pip.py --user --force
	touch done/$@

%-pip:
	cd ${REPOS}/$*; rm -rf build/
	cd ${REPOS}/$*; ${PIP_INSTALL} -v --user --force .
	touch done/$@

# NOT USED
%-pypi:
	pip install -v --user $*
	touch done/$@
%-whl:
	cd ${REPOS}/$*; rm -rf build/
	cd ${REPOS}/$*; python2.7 setup.py -v --no-user-cfg bdist_wheel --bdist-dir ${BDIST_DIR} --dist-dir ${DIST_DIR}
	touch done/$@
