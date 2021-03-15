#!/bin/sh

#
# See ../README.md
#

#
# Run as: perl ch-2.sh < input-file
#
# Each line is a challenge: first number is the target number;
# the rest of the line is the array to search in.
#

set -f

while read -a numbers
do    target=${numbers[0]}
      #
      # Try to find the target, counting from 1
      #
      found=-1
      for  ((i = 1; i < ${#numbers[@]}; i ++))
      do   if   (($target == ${numbers[$i]}))
           then found=$((i - 1))
                break
           fi
      done
      #
      # If found, report the position and go to the next line
      #
      if   (($found >= 0))
      then echo $found
           continue
      fi

      #
      # Create a new array, by sorting numbers
      #
      IFS=$'\n'
      numbers=($(sort -n <<< "${numbers[*]}"))
      unset IFS

      #
      # Search for the target again
      #
      for  ((i = 0; i < ${#numbers[@]}; i ++))
      do   if   (($target == ${numbers[$i]}))
           then found=$i
                break
           fi
      done
      echo $found
done
