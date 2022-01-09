#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -A p

while read n
do   for ((row = 0; row <= n; row ++))
     do  p["$row;0"]=1
         printf "1 "
         for ((col = 1; col <= row; col ++))
         do  p["$row;$col"]=$((${p["$((row-1));$((col-1))"]:-0} + \
                               ${p["$((row-1));$col"]:-0}))
             printf "%d " ${p["$row;$col"]}
         done
         echo
     done
done
