#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

declare -A numbers

while read -a input
do   numbers=()
     for i in "${input[@]}"
     do    ((numbers[$i] ++))
     done
     for i in "${!numbers[@]}"
     do  if   ((numbers[$i] % 2))
         then echo $i
         fi
     done
done
