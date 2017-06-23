set -vex

#pip install -v --user --no-deps --install-option="--swig=$(PREFIX)/bin/swig" --install-option="--swig-lib=$(PREFIX)/share/swig/3.0.8" --install-option="--boost=$(BOOST_ROOT)/include" .

python setup.py -v install --user --boost=${PREFIX}/include
