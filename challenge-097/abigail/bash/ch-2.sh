#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh -s SECTIONS < input-file
#

#
# Disable pathname expansion
#
set -f

#
# Read the option
#
while getopts "s:" name
do  if [ "$name" = "s" ]
    then sections=$OPTARG
    fi
done


#
# Iterate over the input. For each position, count the number of 0s,
# and calculate the number of 1s. Sum the minimum of those numbers.
#
while read line
do    s_len=$((${#line} / $sections))
      sum=0
      for ((i = 0; i < s_len; i ++))
      do   zeros=0
           for ((j = 0; j < sections; j ++))
           do    index=$(($j * $s_len + $i))
                 if   [ "${line:$index:1}" == "0" ]
                 then zeros=$(($zeros + 1))
                 fi
           done
           ones=$(($sections - $zeros))
           sum=$(($sum + ($zeros < $ones ? $zeros : $ones) ))
      done
      echo $sum
done
