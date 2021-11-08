#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

set -f

IFS=","

SUM_15=120
while read number tail; do ((sum += number)); done
echo $((SUM_15 - sum))
