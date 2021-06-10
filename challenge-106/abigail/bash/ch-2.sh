#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare fraction

function long_division () {
    declare numerator=$1
    declare denominator=$2
    declare BASE=10
    fraction=$((numerator / denominator)).
    declare position=${#fraction}
    declare -a seen

    ((numerator %= denominator))

    while ((!seen[numerator]))
    do  if   ((numerator == 0))
        then return
        fi
        seen[$numerator]=$position
        fraction=$fraction$((BASE * numerator / denominator))
        ((numerator =        BASE * numerator % denominator))
        ((position ++))
    done
    fraction=${fraction::${seen[$numerator]}}\(${fraction:${seen[$numerator]}}\)
}


while read numerator denominator
do    long_division $numerator $denominator
      echo $fraction
done


