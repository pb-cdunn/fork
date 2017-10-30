all: done/extra-install

done/extra-install:
	rsync -avL /mnt/software/g/gcc/6.4.0/libc-2.5/compat/lib/libstdc++.so.6 ${PREFIX}/lib
	touch $@
