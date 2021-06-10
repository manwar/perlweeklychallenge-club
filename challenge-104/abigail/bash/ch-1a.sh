#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1a.sh
#


declare -a cache
cache[0]=0
cache[1]=1

max=50

#
# Fusc sequence is defined as:
#            ( n,                                        0 <= n <= 1
# fusc (n) = { fusc  (n / 2),                            n > 1 && n even
#            ( fusc ((n - 1) / 2) + fusc ((n + 1) / 2),  n > 1 && n odd
#

function fusc () {
    local n=$1
    if   ((${cache[$n]} >= 0))
    then fusc_out=${cache[$n]}
         return
    fi

    if   ((n % 2))
    then local p1=$((($1 - 1) / 2))
         local p2=$((($1 + 1) / 2))
         fusc $p1; local f1=$fusc_out
         fusc $p2; local f2=$fusc_out
         cache[$1]=$((f1 + f2))
    else fusc $((n / 2))
         cache[$1]=$fusc_out
    fi

    fusc_out=${cache[$n]}
    return
}

#
# Initialize the cache
#
for ((m = 0; m < max; m ++))
do  cache[$m]=-1
done

cache[0]=0
cache[1]=1

#
# Calculate the first 50 values, and print them.
#
for ((m = 0; m < max; m ++))
do  if ((m > 0))
    then printf " "
    fi
    fusc $m
    printf $fusc_out
done

echo
