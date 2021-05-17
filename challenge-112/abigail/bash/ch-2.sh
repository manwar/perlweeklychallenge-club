#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

declare -A cache
cache[0]=1
cache[1]=1

function fib () {
    local n=$1
    if   [[ -z ${cache[$n]} ]]
    then fib $((n - 1))
         cache[$n]=$result
         fib $((n - 2))
         cache[$n]=$((cache[$n] + result))
    fi
    result=${cache[$n]}
}

while read n
do    fib $n
      echo $result
done
