#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read line
do   line=${line/#[-+]/}   # Get rid of sign
     if [[ $line =~ [^0-9] ]]
     then echo "not an integer"
     elif ((${#line} % 2 == 0))
     then echo "even number of digits"
     elif ((${#line} < 3))
     then echo "too short"
     else echo ${line:$(((${#line} - 3) / 2)):3}
     fi
done
