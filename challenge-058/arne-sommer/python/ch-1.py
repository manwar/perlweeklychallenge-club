#! /usr/bin/env python

from packaging import version
import sys

v1 = version.parse(sys.argv[1])
v2 = version.parse(sys.argv[2])

if v1 > v2:
  print "1"
elif v1 < v2:
  print "-1"
else:
  print "0"
