#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -a best

while read -a houses
do    size=${#houses[@]}
      best[$((size + 0))]=0
      best[$((size + 1))]=0
      for  ((i = size - 1; i >= 2; i --))
      do   ((val1 = ${houses[$i]} + ${best[$((i + 2))]}))
           ((val2 = ${best[$((i + 1))]}))
           best[$i]=$((val1 < val2 ? val2 : val1))
      done

      echo $((${houses[0]} + ${best[2]}))
done
