#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare scores
l=$'\n'
scores[2]=$l

read n

for ((i = 3; i < n + 3; i ++))
do  for ((j = 1; j <= 3; j ++))
    do  scores[$i]=${scores[$i]}${scores[$((i - j))]//$l/$l$j }
    done
done

echo "${scores[$((n + 2))]/$l/}"
