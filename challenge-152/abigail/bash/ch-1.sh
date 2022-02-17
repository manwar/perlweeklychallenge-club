#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read -a F
do   ((minsum = 0))
     ((n      = 1))
     ((m      = n))
     ((min    = 0))
     for num in ${F[@]}
     do  if   ((n == m || num < min))
         then ((min = num))
         fi

         if   ((-- m == 0))
         then ((minsum += min))
              ((m       = ++ n))
              ((min     = 0))
         fi
     done

     echo $minsum

done
