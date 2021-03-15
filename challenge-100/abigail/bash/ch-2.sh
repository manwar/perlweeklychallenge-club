#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#

set -f

#
# Bash only has one-dimensional arrays, so we're using a function
# to map 2-d indices to a 1-d index.
#
# Note also that we can only return numbers 0 - 255 as "return" values
# (by hijacking the return status), which isn't good enough for us,
# so we use the global variable "index" to pass the result back.
#

function idx () {
    local x=$1
    local y=$2
    index=$((x * (x + 1) / 2 + y))
}

#
# Read in the data: we can read a line at the time, and have
# it split on white space, giving use an array of numbers in "row".
# We iterate over the row, mapping the x, y coordinates to a
# single index, and storing the result in the array "numbers".
#

x=0
while read -a row
do    for  ((y = 0; y < ${#row[*]}; y ++))
      do   idx $x $y
           numbers[$index]=${row[$y]}
      done
      x=$((x + 1))
done

#
# Work bottom to top to calculate the minimum path.
#
for  ((r = $x - 2; r >= 0; r --))
do   for  ((y = 0; y <= $r; y ++))
     do   idx $((r + 1)) $y
          val1=${numbers[$index]}
          idx $((r + 1)) $((y + 1))
          val2=${numbers[$index]}
          min=$((val1 < val2 ? val1 : val2))
          idx $r $y
          numbers[$index]=$((numbers[$index] + $min))
     done
done


#
# Print the result.
#
echo ${numbers[0]}
