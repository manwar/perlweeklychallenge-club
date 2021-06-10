#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

function d2b () {
    local d=$1
    b=""
    while ((d > 0))
    do b=$((d % 2))$b
       ((d /= 2))
    done
}

function b2d () {
    local b=$1
    local p=1
    d=""
    while ((${#b} > 0))
    do  if   [[ ${b:$((${#b} - 1))} == "1" ]]
        then ((d += p))
        fi
        ((p *= 2))
        b=${b:0:$((${#b} - 1))}
    done
}


while read number
do    d2b $number
      [[ 0$b =~ ^(.*)(01)(1*)(0*)$ ]]
      b2d ${BASH_REMATCH[1]}10${BASH_REMATCH[4]}${BASH_REMATCH[3]}
      echo $d
done
