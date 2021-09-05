#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#


BEGIN {
    for (i = 0; i < 24 * 60; i ++) {
        trains [i] = 0
    }
}

NR <= 2 {
    for (i = 1; i <= NF; i ++) {
        gsub ("[^0-9:]", "", $i)
        split ($i, chunks, ":")
        minutes = 60 * chunks [1] + chunks [2]
        if (NR == 1) {
            arrivals [i]   = minutes
        }
        else {
            departures [i] = minutes
        }
    }
}

END {
    for (i = 1; i <= length (arrivals); i ++) {
        if (arrivals [i] < departures [i]) {
            for (minute = arrivals [i]; minute <= departures [i]; minute ++) {
                trains [minute] ++
            }
        }
        else {
            for (minute = 0; minute <= departures [i]; minute ++) {
                trains [minute] ++
            }
            for (minute = arrivals [i]; minute < 24 * 60; minute ++) {
                trains [minute] ++
            }
        }
    }
    max = 0
    for (i = 0; i < 24 * 60; i ++) {
        if (max <= trains [i]) {
            max  = trains [i]
        }
    }
    print max
}
