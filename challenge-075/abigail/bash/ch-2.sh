#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

while read -a heights
do    ((max_height = 0))
      for ((i = 0; i < ${#heights[@]}; i ++))
      do  if   ((max_height < ${heights[$i]}))
          then ((max_height = ${heights[$i]}))
          fi
      done

      ((max_area = 0))
      for  ((h = 1; h <= max_height; h ++))
      do   ((max = 0))
           ((cur = 0))
           for ((i = 0; i < ${#heights[@]}; i ++))
           do  if   ((${heights[$i]} >= h))
               then ((cur ++))
               else if   ((cur > max))
                    then ((max = cur))
                    fi
                    ((cur = 0))
               fi
           done
           if   ((cur > max))
           then ((max = cur))
           fi

           ((area = max * h))
           if   ((max_area < area))
           then ((max_area = area))
           fi
      done

      echo $max_area
done
