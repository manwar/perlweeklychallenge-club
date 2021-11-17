#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function is_long (number, rest, seen, i) {
    rest = 0
    delete seen
    for (i = 2; i <= number; i ++) {
        rest = (rest * BASE + BASE - 1) % number
        if (seen [rest]) {return 0}
        seen [rest] = 1
    }
    return 1
}

BEGIN {
    BASE   = 10
    COUNT  =  5
    number =  1

    while (COUNT > 0) {
        number ++
        if (BASE % number == 0) {continue}
        if (is_long(number)) {
            print (number)
            COUNT --
        }
    }
}
