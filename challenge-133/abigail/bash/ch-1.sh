#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read num
do   min=1
     max=$num
     while ((min + 1 < max))
     do   mid=$(((min + max) / 2))
          if ((mid * mid < num))
          then ((min = mid))
          else ((max = mid))
          fi
     done
     echo $min
done
