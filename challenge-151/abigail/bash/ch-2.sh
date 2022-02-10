#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

while read -a h
do    h[${#h[@]}]=0
      h[${#h[@]}]=0
      for  ((i = ${#h[@]} - 3; i >= 2; i --))
      do   ((val1 = ${h[$i]} + ${h[$((i + 2))]}))
           ((val2 = ${h[$((i + 1))]}))
           h[$i]=$((val1 < val2 ? val2 : val1))
      done

      echo $((${h[0]} + ${h[2]}))
done
