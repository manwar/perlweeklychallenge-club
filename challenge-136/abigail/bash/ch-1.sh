#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

#
# Find the GCD, using Euclids algorithm
#    (https://en.wikipedia.org/wiki/Euclidean_algorithm#Implementations)
#
function gcd () {
    local a=$1
    local b=$2
    if   ((b > a))
    then gcd $b $a
    elif ((b == 0))
    then gcd=$a
    else gcd $b $((a % b))
    fi
}

function is_power_of_n () {
    local number=$1
    local n=$2
    if   ((number < 1))
    then is_power_of_n=0
    elif ((number == 1))
    then is_power_of_n=1
    elif ((number % n > 0))
    then is_power_of_n=0
    else is_power_of_n $((number / 2)) $n
    fi
}

function is_power_of_2 () {
    is_power_of_n $1 2
    is_power_of_2=$is_power_of_n
}

set -f


while read n m
do   if ((n % 2 == 1 || m % 2 == 1))
     then echo 0
          continue
     fi
     gcd $n $m
     is_power_of_2 $gcd
     if ((gcd > 1 && is_power_of_2 == 1))
     then echo 1
     else echo 0
     fi
done
