#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

#
# Reverse a given string. Put the result into a global variable reverse.
#
function rev() {
    local in=$1
    reverse=""
    for ((i = 0; i < ${#in}; i ++)) 
    do  reverse=${in:$i:1}$reverse
    done
}

while read number
do    if   [[ $number =~ ^9+$ ]]
      then echo $((number + 2))
           continue
      fi

      #
      # Split input in parts. Length of part1 and part3 are equal.
      # part2 is the middle character if the input number has odd
      # length, and empty otherwise.
      #
      part1=${number:0:$((${#number} / 2))}
      part2=""
      if   ((${#number} % 2))
      then part2=${number:$((${#number} / 2)):1}
      fi
      part3=${number:$(((${#number} + 1) / 2))}
      rev $part1
      if   ((${reverse} > ${part3}))
      then echo $part1$part2$reverse
           continue
      fi

      #
      # Add one of "$part1$part2", and reverse it.
      #
      inc=$(($part1$part2 + 1))
      rev $inc

      #
      # Print result
      #
      echo $inc${reverse:$((${#number} % 2))}
done
