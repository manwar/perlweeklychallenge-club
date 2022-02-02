#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: bash ch-2.sh
#

set -f
PRIMES=(2 3 5 7 11 13 17 19)

for ((n = 1; n <= 500; n ++))
do for p in ${PRIMES[@]}
   do  if ((n % (p * p) == 0))
       then continue 2
       fi
   done
   printf "%d " $n
done

echo
