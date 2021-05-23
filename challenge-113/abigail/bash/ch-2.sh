#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

while read -a numbers
do    sum=0
      for ((i = 0; i < ${#numbers[@]}; i ++))
      do  ((sum += numbers[i]))
      done
      for ((i = 0; i < ${#numbers[@]}; i ++))
      do  if ((i > 0))
          then printf " "
          fi
          printf "%d" $((sum - numbers[i]))
      done
      printf "\n"
done
