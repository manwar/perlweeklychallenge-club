#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{print ((s += $1) / NR)}
