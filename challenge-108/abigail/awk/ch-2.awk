#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk [plain | compute]
#

BEGIN {
    COUNT = 10
    if (!ARGV [1] || ARGV [1] != "compute") {
        printf "%s\n", "1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147"
    }
    else {
        bell [1, 1] = 1
        for (x = 2; x < COUNT; x ++) {
            bell [x, 1] = bell [x - 1, x - 1]
            for (y = 2; y <= x; y ++) {
                bell [x, y] = bell [x, y - 1] + bell [x - 1, y - 1]
            }
        }
        printf "1"
        for (x = 1; x < COUNT; x ++) {
            printf ", %d", bell [x, x]
        }
        printf "\n"
    }
    delete ARGV
}

