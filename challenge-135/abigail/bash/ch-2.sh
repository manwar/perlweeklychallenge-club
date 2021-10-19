#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

w=(1 3 1 7 3 9 1)

while read line
do    if ((${#line} != 7))
      then echo 0
      elif [[ $line =~ [^0-9BCDFGHJKLMNPQRSTVWXYZ] ]]
      then echo 0
      elif [[ $line =~ [^0-9]$ ]]
      then echo 0
      else
          ((check = 0))
          for ((i = 0; i < 7; i ++))
          do  char=${line:$i:1}
              printf -v ord %d "'$char"
              if [[ $char =~ [0-9] ]]
              then ((value = ord - 48))
              else ((value = ord - 65 + 10))
              fi
              ((check += ${w[i]} * value))
          done
          if ((check % 10 == 0))
          then echo 1
          else echo 0
          fi
      fi
done
