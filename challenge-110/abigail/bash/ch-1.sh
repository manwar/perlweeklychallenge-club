#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

IFS=""  # This way, we keep the spaces as is.

valid="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"

while read line
do    raw=${line// }                   # Remove spaces
      raw=${raw/#+/00}                 # Replace leading + with 00
      raw=${raw/#([0-9][0-9])/0000}    # Replace leading (NN) with 0000
      left=${raw/$valid}               # Remove 14 digits
      if [ "X$left" == "X" ]           # If nothing left, the input is valid
      then echo $line                  # Print it
      fi
done
