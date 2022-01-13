#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: bash ch-2.sh < input-file
#

while read max
do  for ((i = 1; i <= $max; i ++))
    do
        out=$i
        if (($i %  3 == 0))
        then out="fizz"
        fi
        if (($i %  5 == 0))
        then out="buzz"
        fi
        if (($i % 15 == 0))
        then out="fizzbuzz"
        fi
        echo $out
    done
done
