#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

declare -a digits

while read -a input
do    #
      # Count the digits of the input
      #
      unset digits
      for   ((i = 0; i < ${#input[@]}; i ++))
      do    ((digits[input[i]] ++))
      done

      #
      # Find smallest even number; this will be last number.
      #
      last=-1
      for   ((i = 8; i >= 0; i -= 2))
      do    if    ((digits[i] > 0))
            then  ((last = i))
            fi
      done

      #
      # Skip if the input doesn't contain an even digit
      #
      if    ((last < 0))
      then  continue
      fi

      ((digits[last] --))

      #
      # Create the output
      #
      out=""
      for   ((i = 9; i >= 0; i --))
      do    for   ((j = 0; j < digits[i]; j ++))
            do    out=$out$i
            done
      done

      echo $out$last
done
