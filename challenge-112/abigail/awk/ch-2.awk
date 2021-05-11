#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

BEGIN {
    SQRT5 = sqrt (5)
    PHI   = (1 + SQRT5) / 2
}

{
    print int (0.5 + PHI ^ ($1 + 1) / SQRT5)
}
