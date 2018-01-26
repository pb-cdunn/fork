#!/usr/bin/env python2.7
import os, sys

for n in sys.argv[1:]:
    print os.path.realpath(n)
