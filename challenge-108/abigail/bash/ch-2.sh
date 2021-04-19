#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh
#

set -f

COUNT=10

function index () {
    local x=$1
    local y=$2
    idx=$((COUNT * x + y))
}


if   [ "X$1" != "Xcompute" ]
then echo "1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147"
else bell[0]=1
     for ((x = 1; x < COUNT - 1; x ++))
     do   index $x 0;                  i1=$idx
          index $((x - 1)) $((x - 1)); i2=$idx
          bell[$i1]=${bell[$i2]}
          for ((y = 1; y <= x; y ++))
          do  index   $x         $y;       i1=$idx
              index   $x       $((y - 1)); i2=$idx
              index $((x - 1)) $((y - 1)); i3=$idx
              bell[$i1]=$((bell[i2] + bell[i3]))
          done
     done

     printf "1"
     for ((x = 0; x < COUNT - 1; x ++))
     do index $x $x;
        printf ", %d" ${bell[$idx]}
     done
     echo
fi
