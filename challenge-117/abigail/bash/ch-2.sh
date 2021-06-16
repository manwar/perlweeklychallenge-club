#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

function steps () {
    local x=$1
    local y=$2
    local prefix=$3
    if   ((x == 0 && y == 0))
    then echo $prefix
         return
    fi
    if   ((x > 0)) 
    then steps $((x - 1)) $y         ${prefix}R
         steps $((x - 1)) $((y + 1)) ${prefix}L
    fi
    if   ((y > 0))
    then steps $x         $((y - 1)) ${prefix}H
    fi
}

read number
steps $number 0 ""
