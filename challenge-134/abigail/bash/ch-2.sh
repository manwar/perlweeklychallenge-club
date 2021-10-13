#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -A seen

while read n m
do   seen=()
     for ((i = 1; i <= n; i ++))
     do  for ((j = 1; j <= m; j ++))
         do  seen[$((i * j))]=1
         done
     done
     echo ${#seen[@]}
done
