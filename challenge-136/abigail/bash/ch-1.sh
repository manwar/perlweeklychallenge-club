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
    local t=0
    while ((b != 0))
    do    ((t = b))
          ((b = a % b))
          ((a = t))
    done
    ((gcd = a))
}

set -f

#
# Calculate the powers of 2 (greater than 1). 2^62 is the max a bash
# integer holds
#
declare -a power_of_2
for ((i = 1; i <= 62; i ++))
do  power_of_2[$((1 << i))]=1
done

while read n m
do   gcd $n $m
     echo ${power_of_2[$gcd]:-0}
done
