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
    local path=$3
    if   ((x == 0 && y == 0))
    then echo $path
         return
    fi
    if   ((x > 0)) 
    then steps $((x - 1)) $y         ${path}R
         steps $((x - 1)) $((y + 1)) ${path}L
    fi
    if   ((y > 0))
    then steps $x         $((y - 1)) ${path}H
    fi
}

read number
steps $number 0 ""
