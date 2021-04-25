#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk [plain | compute]
#

function divisor_sum (n, i) {
    sum = 0
    for (i = 2; i <= n / 2; i ++) {
        if (n % i == 0) {
            sum += i
        }
    }
    return (sum)
}

BEGIN {
    COUNT = 20
    if (!ARGV [1] || ARGV [1] != "compute") {
        print "0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21"
    }
    else {
        for (i = 1; i <= COUNT; i ++) {
            if (i > 1) {
                printf ", ";
            }
            printf "%d", divisor_sum(i)
        }
        printf "\n";
    }
    delete ARGV
}

