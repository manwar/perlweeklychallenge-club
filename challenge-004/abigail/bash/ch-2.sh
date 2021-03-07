#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-2.sh -f FILE < input-file
#

#
# Disable pathname expansion
#
set -f

#
# Read the option
#
while getopts "f:" name
do  if [ "$name" = "f" ]
    then file=$OPTARG
    fi
done


while read letters
do    letters=${letters^^[a-z]}        # Upper case the letters
      while read word                  # Read word from file
      do    copy=${word^^[a-z]}        # Make a copy, and upper case it
            for   ((i = 0; i < ${#letters}; i ++))  # Iterate over letters
            do    copy=${copy/${letters:$i:1}/}     # Remove letter from copy
            done
            if    [ ${#copy} -eq 0 ]   # If we end up with an empty
            then  echo $word           # string, we have a winner
            fi
      done < $file                     # We're reading from the $file
done
