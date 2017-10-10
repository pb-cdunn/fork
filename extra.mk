all: done/extra-install

done/extra-install:
	rsync -av $$(which nucmer) ${PREFIX}/bin/
	rsync -av $$(which show-coords) ${PREFIX}/bin/
	touch $@
