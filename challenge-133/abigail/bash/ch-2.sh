#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh
#

set -f

small_primes=(2 3 5 7 11 13 17 19 23 29 31)

function factorize () {
    factors=()
    local num=$1
    for prime in "${small_primes[@]}"
    do  while ((num % prime == 0))
        do    ((num = num / prime))
              factors+=($prime)
        done
    done
    if ((num > 1))
    then factors+=($num)
    fi
}
              

function digit_sum () {
    digit_sum=0
    for num in "$@"
    do  while ((num > 0))
        do    ((digit_sum += num % 10))
              ((num       /= 10))
        done
    done
}


count=0
number=1

while ((count < 10))
do  factorize $number
    if   ((${#factors[@]} > 1))
    then digit_sum ${factors[@]}; ds1=$digit_sum
         digit_sum $number;       ds2=$digit_sum
         if   ((ds1 == ds2))
         then echo $number
              ((count = count + 1))
         fi
    fi
    ((number = number + 1))
done
