#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh
#

set -f

BASE=10
COUNT=5

function is_long () {
    local number=$1
    local rest=0
    local seen=()

    for ((i = 0; i < number; i ++))
    do seen[$i]=0
    done

    for ((i = 2; i <= number; i ++))
    do  ((rest = (rest * BASE + BASE - 1) % number))
        if   ((${seen[$rest]} == 1))
        then is_long=0
             return
        fi
        seen[$rest]=1
    done

    is_long=1
}

number=1
while ((COUNT > 0))
do  ((number ++))
    if   ((BASE % number != 0))
    then is_long $number
         if   (($is_long == 1))
         then echo $number
              ((COUNT --))
         fi
    fi
done
