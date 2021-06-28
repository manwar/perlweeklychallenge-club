#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {SUM_15 = 120}
      {sum += $1}
END   {print SUM_15 - sum}
