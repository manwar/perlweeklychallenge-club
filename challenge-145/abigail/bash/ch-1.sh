#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

read -a a
read -a b
for ((i = 0; i < ${#a[@]}; i ++))
do  ((sum += a[i] * b[i]))
done
echo $sum
