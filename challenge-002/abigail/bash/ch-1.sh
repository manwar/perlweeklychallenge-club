#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

shopt -s extglob

while read number
do echo "${number##+(0)}"
done
