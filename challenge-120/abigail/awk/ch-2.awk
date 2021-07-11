#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

BEGIN {
    FS = ":"
    DIFF_PER_MINUTE =  11
    MIN_PER_HOUR    =  60
    FULL_CIRCLE     = 720
}

{
    angle = (DIFF_PER_MINUTE * ($1 * MIN_PER_HOUR + $2)) % FULL_CIRCLE
    if (2 * angle >= FULL_CIRCLE) {
        angle = FULL_CIRCLE - angle
    }

    print (angle / 2)
}
