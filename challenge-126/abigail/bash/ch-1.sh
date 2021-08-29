#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read n
do    ((result   = 0))
      ((seen_one = 0))
      for ((i = 0; i < ${#n}; i ++))
      do    digit=${n:$i:1}
            ((result *= 9))
            if    ((seen_one == 1))
            then  ((result += 8))
            else  if    ((digit == 1))
                  then  ((seen_one = 1))
                  else  if    ((digit != 0))
                        then  ((result += digit - 1))
                        fi
                  fi
            fi
      done
      echo $result
done
