#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

declare -A matrix
MATRIX_SIZE=5

#
# Read in the matrix
#
for   ((i = 1; i <= $MATRIX_SIZE; i ++))
do    read -a line
      for n in ${line[@]}
      do  matrix[$n]=1
      done
done

#
# Print 1/0 depending or not whether the number is in the matrix
#
while read number
do    echo $((matrix[$number] ? 1 : 0))
done
