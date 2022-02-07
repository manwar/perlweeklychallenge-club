#!/bin/sh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

declare -a best

while read -a houses
do    if   [[ ${#houses[@]} -lt 2 ]]
      then echo ${houses[0]}
           continue
      fi

      size=${#houses[@]}
      for  ((i = size - 1; i >= 0; i --))
      do   ((i1 = i + 1))
           ((i2 = i + 2))
           if ((i == size - 1))
           then best[$i]=${houses[$i]}
                continue
           fi

           if ((i == 0))
           then best[$i]=$((${houses[$i]} + ${best[$i2]}))
                continue
           fi

           if   ((i == size - 2))
           then val1=${houses[$i]}
                val2=${best[$i1]}
           else val1=$((${houses[$i]} + ${best[$i2]}))
                val2=${best[$i1]}
           fi

           best[$i]=$((val1 < val2 ? val2 : val1))
      done

      echo ${best[0]}
done
