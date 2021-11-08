#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read m n
do    ((n = 2 ** (n - 1)))
      if  (((m / n) % 2))
      then ((m = m  - n))
      else ((m = m  + n))
      fi
      echo $m
done
