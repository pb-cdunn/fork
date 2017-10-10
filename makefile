default:
all: setup fetch cpp python
all-pb: setup fetch-pb cpp python extra
.NOTPARALLEL:
# -j is fine. We turn it off where needed.

setup:
	mkdir -p ${PREFIX}/include
	mkdir -p ${PREFIX}/lib
	mkdir -p ${PREFIX}/bin
	mkdir -p done/ repos/
	${MAKE} -f python.mk install-pip
	cp -f ./realpath.py ${PREFIX}/bin/realpath


fetch:
	${MAKE} -f fetch.mk

fetch-pb:
	${MAKE} -f fetch-pb.mk

cpp:
	${MAKE} -f cpp.mk all

python: cpp
	${MAKE} -f python.mk all

extra:
	${MAKE} -f extra.mk all

manifest:
	bash manifest.sh >| ${PREFIX}/lib/MANIFEST

id:
	bash id.sh >| ${PREFIX}/lib/ID

# Be sure to source env.sh before using this makefile.
