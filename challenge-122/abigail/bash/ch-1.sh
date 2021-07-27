#!/bin/sh

#
# See ../README.md
#

#
# Run as: bash ch-1.sh < input-file
#

while read n; do echo $(((s += n) / ++ c)); done
