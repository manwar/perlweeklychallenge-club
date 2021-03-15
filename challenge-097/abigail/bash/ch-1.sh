#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh -s SHIFT < input-file
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
    then shift=$OPTARG
    fi
done


#
# Iterate over the input, shifting each line as many times as needed
#
while read line
do    for ((i = 0; i < $shift; i ++))
      do line=`echo $line | tr A-Z ZA-Y`
      done
      echo $line
done
