#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

LENGTH=51

while read fib_prev fib_last
do   while ((${#fib_last} < LENGTH))
     do  fib_tmp=$fib_last
         fib_last=$fib_prev$fib_last
         fib_prev=$fib_tmp
     done
     echo ${fib_last:$((LENGTH - 1)):1}
done
