#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -A cache

function count () {
    local target=$1
    local this_fib=${2:-1}
    local prev_fib=${3:-1}

    local key=$target";"$this_fib

    if [ ! -v 'cache[$key]' ]
    then if   ((target <  this_fib))
         then cache[$key]=0
         elif ((target == this_fib))
         then cache[$key]=1
         else count $((target - this_fib)) $((this_fib + prev_fib)) $this_fib
              local sum=$count
              count $target                $((this_fib + prev_fib)) $this_fib
              cache[$key]=$((count + sum))
         fi
    fi

    count=${cache[$key]}
}

while read target
do   count $target
     echo $count
done
