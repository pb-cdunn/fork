Within PacBio:
```
export UCS=4
source env-pb.sh
source env.sh # must come after env-pb, so we have pip at front of PATH
make setup
make fetch-pb
make -j all-pb
```
