#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f
shopt -s extglob

function reverse () {
    local str=$1
    local len=${#str}
    local rev=""
    for ((i = len - 1; i >= 0; i --))
    do  rev=$rev${str:$i:1}
    done
    reverse=$rev
}

function ly () {
    local n=$1
    reverse $n
    local rev=${reverse/#+(0)/}
    if ((n >= 10000000))
    then ly=1
    elif [[ $n = $rev ]]
    then ly=0
    else ly $((n + rev))
    fi
}

while read number
do  ly $number
    echo $ly
done
