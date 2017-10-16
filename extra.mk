all: done/extra-install

done/extra-install:
	rsync -avL $$(which nucmer) ${PREFIX}/bin/
	rsync -avL $$(which show-coords) ${PREFIX}/bin/
	touch $@
