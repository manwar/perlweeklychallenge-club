#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

function substrings () {
    local n=$1
    local m=$2
    local prefix=$3
    local max=$4
    local r
    if [ -z "$n" ]
    then if   (( prefix > -1 && prefix < max && prefix % m == 0))
         then ((r = 1))
         else ((r = 0))
         fi
    else local tail=${n:1}
         local fc=${n:0:1}
         local n_prefix=$fc
         if   ((prefix > -1))
         then ((n_prefix = 10 * prefix + fc))
         fi
         substrings "$tail" $m $n_prefix $max; local r1=$substrings
         substrings "$tail" $m   $prefix $max; local r2=$substrings
         ((r = r1 + r2))
    fi
    substrings=$r
}

while read n m
do   substrings $n $m -1 $n
     echo $substrings
done
