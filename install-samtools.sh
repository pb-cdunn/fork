# Required vars: PREFIX
set -vex

SAM_ROOT=/mnt/software/s/samtools/1.3.1
rsync -av ${SAM_ROOT}/bin/samtools ${PREFIX}/bin/
rsync -av ${SAM_ROOT}/lib/libncurses*.so* ${PREFIX}/lib/
${PREFIX}/bin/samtools --help
