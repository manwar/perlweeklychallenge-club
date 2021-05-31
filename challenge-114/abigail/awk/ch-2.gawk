#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: gawk -f ch-2.gawk < input-file
#

#
# Take a number, and return a binary representation
#
function d2b (d, b) {
    b = ""
    while (d > 0) {
        b = d % 2 b
        d = int (d / 2)
    }
    return (b)
}

#
# Take a binary representation of a number, return that number.
#
function b2d (b, d, i) {
    d = 0
    i = 0
    while (length (b) > 0) {
        if (substr (b, length (b), 1) == "1") {
            d += 2 ^ i
        }
        i ++
        b = substr (b, 1, length (b) - 1)
    }
    return (d)
}


{
    #
    # Take a number, turn it into a binary representation (d2b), prepend a 0.
    # Replace the last 01 with 10, and swap trailing sequence of 1s and 0s.
    # Turn this back into a decimal representation, and print it.
    #
    print (b2d(gensub (/^(.*)01(1*)(0*)$/, "\\110\\3\\2", 1, 0 d2b($1))))
}
