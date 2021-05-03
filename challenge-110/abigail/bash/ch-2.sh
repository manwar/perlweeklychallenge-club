#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh < input-file
#


declare -a out

#
# Read in the data, add each field to the appropriate output string
#
IFS=,
while read -a chunks
do    for   ((i = 0; i < ${#chunks[@]}; i ++))
      do    out[$i]=${out[$i]}${chunks[$i]},
      done
done

#
# Print the output string, dropping the final comma
#
IFS=""
for   ((i = 0; i < ${#out[@]}; i ++))
do    echo ${out[$i]:0:-1}
done
