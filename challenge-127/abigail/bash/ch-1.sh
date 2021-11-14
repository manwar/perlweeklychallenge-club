#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

declare -A seen

while read -a numbers
do    seen=()

      #
      # Histogram of numbers. Get rid of separator
      #
      for  number in ${numbers[@]}
      do   ((seen[${number/;/}] ++))
      done

      #
      # Print 1/0 depending on whether they are disjunct or not
      #
      ((out = 1))
      for val in ${seen[@]}
      do  if   ((val > 1))
          then ((out = 0))
          fi
      done
      echo $out
done
