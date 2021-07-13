#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read num
do    echo $(( (num & 0x55) << 1
             | (num & 0xAA) >> 1 ))
done
