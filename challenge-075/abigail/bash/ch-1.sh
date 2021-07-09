#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

function possibilities () {
    local target=$1
    local from=$2
    local to=$3
    local i=0

    if ((target == 0)) 
    then result=1
         return
    fi

    if (((target < 0) || (from > to)))
    then result=0
         return
    fi

    local sum=0
    for ((i = 0; i * ${coins[from]} <= target; i ++))
    do  possibilities $((target - i * ${coins[from]})) $((from + 1)) $to
        ((sum += result))
    done

    ((result = sum))
    return
}

while read -a coins
do   target=${coins[0]}
     possibilities $target 1 $((${#coins[@]} - 1))
     echo $result
done
