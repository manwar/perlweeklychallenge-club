#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {
    ugly [0] = 1
    next_2   = 0
    next_3   = 0
    next_5   = 0
    count    = 1
}

{
    while (count < $1) {
        c2 = 2 * ugly [next_2]
        c3 = 3 * ugly [next_3]
        c5 = 5 * ugly [next_5]

        ugly [count] = c2 < c3 ? c2 < c5 ? c2 : c5 \
                               : c3 < c5 ? c3 : c5

        if (2 * ugly [next_2] <= ugly [count]) {next_2 ++}
        if (3 * ugly [next_3] <= ugly [count]) {next_3 ++}
        if (5 * ugly [next_5] <= ugly [count]) {next_5 ++}
                                         
        count ++
    }
    print ugly [$1 - 1]
}




