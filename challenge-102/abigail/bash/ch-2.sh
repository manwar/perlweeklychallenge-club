#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#


#
# Working from the end of the required string backwards, we alternate
# placing a hash, and placing a number. We place them in an array out,
# and at the end, print out said array in reverse order.
#

while read index
do    declare -a out
      hash=0
      i=0
      while ((index > 0))
      do    ((i ++))
            if   ((hash = !hash))
            then out[$i]="#"
                 ((index --))
            else number=$((index + 1))
                 out[$i]=$number
                 ((index -= ${#number}))
            fi
      done
      for ((; i; i --))
      do  printf "%s" ${out[$i]}
      done
      echo
done
      
