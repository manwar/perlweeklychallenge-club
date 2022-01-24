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

f=0
g=1
declare -A fib
fib[$f]=1
fib[$g]=1

function is_fib () {
    local n=$1
    while (($g < $n))
    do   ((t = g))
         ((g = f + g))
         ((f = t))
         fib[$g]=1
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
