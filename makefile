default:
all: setup fetch cpp python
all-pb: setup fetch-pb cpp python extra
	${MAKE} manifest
.NOTPARALLEL:
# -j is fine. We turn it off where needed.

setup: | repos
	mkdir -p ${PREFIX}/include
	mkdir -p ${PREFIX}/lib
	mkdir -p ${PREFIX}/bin
	mkdir -p done/
	${MAKE} -f python.mk install-pip
	#cp -f ./realpath.py ${PREFIX}/bin/realpath

repos:
	mkdir -p $@

fetch: | repos
	${MAKE} -f fetch.mk

fetch-pb: | repos
	${MAKE} -f fetch-pb.mk

cpp:
	${MAKE} -f cpp.mk all

python: cpp
	${MAKE} -f python.mk all

extra:
	${MAKE} -f extra.mk all

manifest:
	bash manifest.sh >| ${PREFIX}/lib/MANIFEST
	cp -f CHANGES.md ${PREFIX}/lib/

id:
	bash id.sh >| ${PREFIX}/lib/ID

distclean:
	git clean -xdf .
	rm -rf repos/

# Be sure to source env.sh before using this makefile.
