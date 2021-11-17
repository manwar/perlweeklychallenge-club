#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read -a list
do    ((sorted = 1))
      for ((i = 1; i < ${#list[@]}; i ++))
      do  if ((${list[$i - 1]} > ${list[$i]}))
          then ((sorted = 0))
          fi
      done
      echo $sorted
done
