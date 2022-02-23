#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -a fac
fac[0]=1
for ((n = 1; n <= 9; n ++))
do  fac[$n]=$((n * ${fac[$((n - 1))]}))
done

while read num
do   ((n   = num))
     ((sum = 0))
     while ((n > 0))
     do    ((sum += ${fac[n % 10]}))
           ((n   /= 10))
     done
     if   ((sum == num))
     then echo 1
     else echo 0
     fi
done
