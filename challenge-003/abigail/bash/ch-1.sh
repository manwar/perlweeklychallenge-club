#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read max
do   for  ((base2 = 1; $base2 <= $max; base2 *= 2))
     do   for  ((base3 = $base2; $base3 <= $max; base3 *= 3))
          do   for  ((base5 = $base3; $base5 <= $max; base5 *= 5))
               do   echo $base5
               done
          done
    done
done
