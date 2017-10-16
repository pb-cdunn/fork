all: done/extra-install

done/extra-install:
	rsync -avL $$(which nucmer) ${PREFIX}/bin/
	rsync -avL $$(which show-coords) ${PREFIX}/bin/
	rsync -avL /mnt/software/g/gcc/6.4.0/libc-2.5/compat/lib/libstdc++.so.6 ${PREFIX}/lib
	touch $@
