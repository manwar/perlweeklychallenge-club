#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

declare -a N

#
# Bash does not have a buildin sort function. 
# So, we're implementing a selection sort here.
#
# We always sort the array N
#
function ssort() {
    for ((i = 0; i < ${#N[*]}; i ++))
    do for ((j = i + 1; j < ${#N[*]}; j ++))
       do  if ((N[j] < N[i]))
           then t=${N[$i]}
                N[$i]=${N[$j]]}
                N[$j]=$t
           fi
       done
    done
}

#
# Read in the data, into an array N
#
while read -a N
do    ssort  # Sort the array N
      #
      # Find the maximum value
      #
      max=0
      for ((i = 1; i < ${#N[*]}; i ++))
      do  if   (((N[i] - N[i - 1]) > max))
          then max=$((N[i] - N[i - 1]))
          fi
      done
      #
      # Print the maximum
      #
      echo $max
done
