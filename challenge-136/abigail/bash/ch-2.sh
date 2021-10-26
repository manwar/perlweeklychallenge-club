#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

function count () {
    local target=$1
    local this_fib=${2:-1}
    local prev_fib=${3:-1}

    if   ((target <  this_fib))
    then count=0
    elif ((target == this_fib))
    then count=1
    else count $((target - this_fib)) $((this_fib + prev_fib)) $this_fib
         local sum=$count
         count $target                $((this_fib + prev_fib)) $this_fib
         count=$((count + sum))
    fi
}

while read target
do   count $target
     echo $count
done
