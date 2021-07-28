#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

while read x1 y1 x2 y2 x3 y3 x4 y4
do    ((e1 = (x1 - x2) ** 2 + (y1 - y2) ** 2))
      ((e2 = (x2 - x3) ** 2 + (y2 - y3) ** 2))
      ((e3 = (x3 - x4) ** 2 + (y3 - y4) ** 2))
      ((e4 = (x4 - x1) ** 2 + (y4 - y1) ** 2))
      ((d1 = (x1 - x3) ** 2 + (y1 - y3) ** 2))
      ((d2 = (x2 - x4) ** 2 + (y2 - y4) ** 2))
      if ((e1 == e2 && e2 == e3 && e3 == e4 && d1 == d2))
      then echo 1
      else echo 0
      fi
done
