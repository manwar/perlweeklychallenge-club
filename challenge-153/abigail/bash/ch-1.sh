#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: bash ch-1.sh
#

set -f

((sum = 1))
((fac = 1))
printf %d $sum
for ((n = 1; n <= 9; n ++))
do  ((fac *= n))
    ((sum += fac))
    printf " %d" $sum
done
echo
