#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

while read num
do    echo $((  (num & ~0xFF) 
              | (num &  0x0F) << 4
              | (num &  0xF0) >> 4 ))
done
