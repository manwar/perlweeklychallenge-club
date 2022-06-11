#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: bash ch-1.sh < input-file
#

function digit_sum () {
    digit_sum=0
    num=$1
    while ((num > 0))
    do    ((digit_sum += num % 10))
          ((num       /= 10))
    done
}

fib_prev=0
fib_last=1
declare -A fib
fib[$fib_prev]=1
fib[$fib_last]=1

function is_fib () {
    local n=$1
    while (($fib_last < $n))
    do   ((t        = fib_last))
         ((fib_last = fib_prev + fib_last))
         ((fib_prev = t))
         fib[$fib_last]=1
    done
    is_fib=${fib[$n]:-0}
}

set -f

while read N
do   for ((k = 0; N > 0; k ++))
     do  digit_sum $k
         is_fib $digit_sum
         if   (($is_fib == 1))
         then printf "%d " $k
              ((N --))
         fi
     done
     echo ""
done
