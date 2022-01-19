#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

IFS=/

while read a b
do   for ((i = 1; i <= 2; i ++))
     do  if   ((a < b))
         then ((b -= a))
         else ((a -= b))
         fi
         if   ((a == 0 || b == 0))
         then break
         fi
         printf "$a/$b "
     done
     echo
done
