#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

function dist () {((dist = ($1 - $3) ** 2 + ($2 - $4) ** 2))}

while read x1 y1 x2 y2 x3 y3 x4 y4
do    dist $x1 $y1 $x2 $y2; ((e1 = dist))
      dist $x2 $y2 $x3 $y3; ((e2 = dist))
      dist $x3 $y3 $x4 $y4; ((e3 = dist))
      dist $x4 $y4 $x1 $y1; ((e4 = dist))
      dist $x1 $y1 $x3 $y3; ((d1 = dist))
      dist $x2 $y2 $x4 $y4; ((d2 = dist))
      if ((e1 == e2 && e2 == e3 && e3 == e4 && d1 == d2))
      then echo 1
      else echo 0
      fi
done
