set -vex
rm -rf _build
mkdir -p _build

meson \
  --default-library shared \
  --libdir lib \
  --unity "${ENABLED_UNITY_BUILD:-off}" \
  --wrap-mode nofallback \
  --prefix "${PREFIX_ARG:-/usr/local}" \
  -Dtests="${ENABLED_TESTS:-false}" \
  "${CURRENT_BUILD_DIR:-_build}" .

# build
ninja -C "${CURRENT_BUILD_DIR:-_build}" -v
rsync -av _build/bam2fasta _build/bam2fastq ${PREFIX}/bin
